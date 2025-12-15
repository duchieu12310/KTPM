package vn.nhom13.laptopshop.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.nhom13.laptopshop.domain.Factory;
import vn.nhom13.laptopshop.domain.Product;
import vn.nhom13.laptopshop.service.FactoryService;
import vn.nhom13.laptopshop.service.ProductService;
import vn.nhom13.laptopshop.service.UploadService;

@Controller
@RequestMapping("/admin/product")
public class ProductController {

    private final ProductService productService;
    private final FactoryService factoryService;
    private final UploadService uploadService;

    public ProductController(ProductService productService,
            FactoryService factoryService,
            UploadService uploadService) {
        this.productService = productService;
        this.factoryService = factoryService;
        this.uploadService = uploadService;
    }

    // ===== SHOW LIST PRODUCTS =====
    @GetMapping({ "", "/" })
    public String showProducts(@RequestParam(defaultValue = "1") int page, Model model) {
        int pageSize = 10;
        Page<Product> productsPage = productService.fetchProducts(PageRequest.of(page - 1, pageSize));

        model.addAttribute("products", productsPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productsPage.getTotalPages());

        return "admin/product/show"; // /WEB-INF/views/admin/product/show.jsp
    }

    // ===== CREATE PAGE =====
    @GetMapping("/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        model.addAttribute("factories", factoryService.fetchAllFactories());
        return "admin/product/create";
    }

    // ===== HANDLE CREATE =====
    @PostMapping("/create")
    public String handleCreateProduct(
            @ModelAttribute("newProduct") @Valid Product product,
            BindingResult result,
            @RequestParam("nhom13File") MultipartFile file,
            Model model) {

        if (result.hasErrors()) {
            model.addAttribute("factories", factoryService.fetchAllFactories());
            return "admin/product/create";
        }

        // Lấy Factory theo ID
        if (product.getFactoryId() != null) {
            Factory factory = factoryService.fetchFactoryById(product.getFactoryId())
                    .orElseThrow(() -> new RuntimeException("Factory not found"));
            product.setFactory(factory);
        }

        // Xử lý file ảnh
        if (!file.isEmpty()) {
            String image = uploadService.handleSaveUploadFile(file, "product");
            product.setImage(image);
        }

        productService.createProduct(product);

        return "redirect:/admin/product";
    }

    // ===== UPDATE PAGE =====
    @GetMapping("/update/{id}")
    public String getUpdateProductPage(@PathVariable long id, Model model) {
        Product product = productService.fetchProductById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        model.addAttribute("product", product);
        model.addAttribute("factories", factoryService.fetchAllFactories());
        return "admin/product/update";
    }

    // ===== HANDLE UPDATE =====
    @PostMapping("/update/{id}")
    public String handleUpdateProduct(
            @PathVariable long id,
            @ModelAttribute("product") @Valid Product product,
            BindingResult result,
            @RequestParam("nhom13File") MultipartFile file,
            Model model) {

        if (result.hasErrors()) {
            model.addAttribute("factories", factoryService.fetchAllFactories());
            return "admin/product/update";
        }

        Product existingProduct = productService.fetchProductById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        existingProduct.setName(product.getName());
        existingProduct.setPrice(product.getPrice());

        if (product.getFactoryId() != null) {
            Factory factory = factoryService.fetchFactoryById(product.getFactoryId())
                    .orElseThrow(() -> new RuntimeException("Factory not found"));
            existingProduct.setFactory(factory);
        }

        if (!file.isEmpty()) {
            String image = uploadService.handleSaveUploadFile(file, "product");
            existingProduct.setImage(image);
        }

        productService.createProduct(existingProduct); // save lại sản phẩm

        return "redirect:/admin/product";
    }

    @GetMapping("/products")
    public String showProducts(Model model) {
        List<Factory> factories = factoryService.fetchAllFactories(); // Lấy danh sách từ DB
        List<Product> products = productService.fetchAllProducts(); // Lấy danh sách sản phẩm

        model.addAttribute("factories", factories);
        model.addAttribute("products", products);

        return "client/product/show"; // đường dẫn JSP
    }

    // ===== DELETE PRODUCT =====
    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable long id) {
        productService.deleteProduct(id);
        return "redirect:/admin/product";
    }

    // ===== VIEW PRODUCT =====
    @GetMapping("/{id}")
    public String viewProduct(@PathVariable long id, Model model) {
        Product product = productService.fetchProductById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        model.addAttribute("product", product);
        return "admin/product/view";
    }
}
