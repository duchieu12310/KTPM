package vn.nhom13.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.nhom13.laptopshop.domain.Cart;
import vn.nhom13.laptopshop.domain.CartDetail;
import vn.nhom13.laptopshop.domain.Order;
import vn.nhom13.laptopshop.domain.OrderDetail;
import vn.nhom13.laptopshop.domain.Product;
import vn.nhom13.laptopshop.domain.User;
import vn.nhom13.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.nhom13.laptopshop.repository.CartDetailRepository;
import vn.nhom13.laptopshop.repository.CartRepository;
import vn.nhom13.laptopshop.repository.OrderDetailRepository;
import vn.nhom13.laptopshop.repository.OrderRepository;
import vn.nhom13.laptopshop.repository.ProductRepository;
import vn.nhom13.laptopshop.service.specification.ProductSpecs;

@Service
public class ProductService {

    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(
            ProductRepository productRepository,
            CartRepository cartRepository,
            CartDetailRepository cartDetailRepository,
            UserService userService,
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {

        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    // ================= PRODUCT CRUD =================

    public Product createProduct(Product product) {
        return this.productRepository.save(product);
    }

    public Page<Product> fetchProducts(Pageable page) {
        return this.productRepository.findAll(page);
    }

    public Optional<Product> fetchProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProduct(long id) {
        this.productRepository.deleteById(id);
    }

    public List<Product> fetchAllProducts() {
        return this.productRepository.findAll();
    }

    public void handleDeleteAllCart(User user, HttpSession session) {
        Cart cart = this.fetchByUser(user);
        if (cart == null)
            return;

        // Xóa toàn bộ cart detail
        this.cartDetailRepository.deleteAll(cart.getCartDetails());

        // Clear trong entity
        cart.getCartDetails().clear();
        this.cartRepository.save(cart);

        // Update session (icon cart)
        session.setAttribute("sum", 0);
    }

    // ================= FILTER / SPEC =================

    public Page<Product> fetchProductsWithSpec(Pageable page, ProductCriteriaDTO dto) {

        if (dto.getTarget() == null
                && dto.getFactory() == null
                && dto.getPrice() == null) {
            return this.productRepository.findAll(page);
        }

        Specification<Product> combinedSpec = Specification.where(null);

        if (dto.getTarget() != null && dto.getTarget().isPresent()) {
            combinedSpec = combinedSpec.and(
                    ProductSpecs.matchListTarget(dto.getTarget().get()));
        }

        if (dto.getFactory() != null && dto.getFactory().isPresent()) {
            combinedSpec = combinedSpec.and(
                    ProductSpecs.matchListFactory(dto.getFactory().get()));
        }

        if (dto.getPrice() != null && dto.getPrice().isPresent()) {
            combinedSpec = combinedSpec.and(
                    buildPriceSpecification(dto.getPrice().get()));
        }

        return this.productRepository.findAll(combinedSpec, page);
    }

    // ================= PRICE FILTER =================

    public Specification<Product> buildPriceSpecification(List<String> price) {

        Specification<Product> combinedSpec = Specification.where(null);

        for (String p : price) {
            double min = 0;
            double max = 0;

            switch (p) {
                case "duoi-10-trieu":
                    min = 1;
                    max = 10_000_000;
                    break;
                case "10-15-trieu":
                    min = 10_000_000;
                    max = 15_000_000;
                    break;
                case "15-20-trieu":
                    min = 15_000_000;
                    max = 20_000_000;
                    break;
                case "tren-20-trieu":
                    min = 20_000_000;
                    max = 200_000_000;
                    break;
            }

            if (min > 0 && max > 0) {
                combinedSpec = combinedSpec.or(
                        ProductSpecs.matchMultiplePrice(min, max));
            }
        }
        return combinedSpec;
    }

    // ================= CART =================

    public void handleAddProductToCart(
            String email,
            long productId,
            HttpSession session,
            long quantity) {

        User user = this.userService.getUserByEmail(email);
        if (user == null)
            return;

        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null) {
            cart = new Cart();
            cart.setUser(user);
            cart.setSum(0);
            cart = this.cartRepository.save(cart);
        }

        Optional<Product> productOptional = this.productRepository.findById(productId);
        if (productOptional.isEmpty())
            return;

        Product product = productOptional.get();

        CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, product);

        if (oldDetail == null) {
            CartDetail cd = new CartDetail();
            cd.setCart(cart);
            cd.setProduct(product);
            cd.setPrice(product.getPrice());
            cd.setQuantity(quantity);
            this.cartDetailRepository.save(cd);

            int sum = cart.getSum() + 1;
            cart.setSum(sum);
            this.cartRepository.save(cart);
            session.setAttribute("sum", sum);
        } else {
            oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
            this.cartDetailRepository.save(oldDetail);
        }
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {

        Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetailId);

        if (cdOptional.isEmpty())
            return;

        CartDetail cartDetail = cdOptional.get();
        Cart cart = cartDetail.getCart();

        this.cartDetailRepository.deleteById(cartDetailId);

        if (cart.getSum() > 1) {
            int sum = cart.getSum() - 1;
            cart.setSum(sum);
            session.setAttribute("sum", sum);
            this.cartRepository.save(cart);
        } else {
            this.cartRepository.deleteById(cart.getId());
            session.setAttribute("sum", 0);
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cd : cartDetails) {
            Optional<CartDetail> optional = this.cartDetailRepository.findById(cd.getId());
            if (optional.isPresent()) {
                CartDetail current = optional.get();
                current.setQuantity(cd.getQuantity());
                this.cartDetailRepository.save(current);
            }
        }
    }

    // ================= ORDER =================

    public void handlePlaceOrder(
            User user,
            HttpSession session,
            String receiverName,
            String receiverAddress,
            String receiverPhone) {

        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null)
            return;

        List<CartDetail> cartDetails = cart.getCartDetails();
        if (cartDetails == null || cartDetails.isEmpty())
            return;

        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverPhone(receiverPhone);
        order.setStatus("PENDING");

        double total = 0;
        for (CartDetail cd : cartDetails) {
            total += cd.getPrice() * cd.getQuantity();
        }
        order.setTotalPrice(total);
        order = this.orderRepository.save(order);

        for (CartDetail cd : cartDetails) {
            OrderDetail od = new OrderDetail();
            od.setOrder(order);
            od.setProduct(cd.getProduct());
            od.setPrice(cd.getPrice());
            od.setQuantity(cd.getQuantity());
            this.orderDetailRepository.save(od);
        }

        for (CartDetail cd : cartDetails) {
            this.cartDetailRepository.deleteById(cd.getId());
        }

        this.cartRepository.deleteById(cart.getId());
        session.setAttribute("sum", 0);
    }
}
