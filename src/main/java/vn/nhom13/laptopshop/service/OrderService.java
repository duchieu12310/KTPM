package vn.nhom13.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.nhom13.laptopshop.domain.Order;
import vn.nhom13.laptopshop.domain.OrderDetail;
import vn.nhom13.laptopshop.domain.User;
import vn.nhom13.laptopshop.repository.OrderDetailRepository;
import vn.nhom13.laptopshop.repository.OrderRepository;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    // ================== FETCH ==================
    public Page<Order> fetchAllOrders(Pageable pageable) {
        return this.orderRepository.findAll(pageable);
    }

    public List<Order> fetchOrderByUser(User user) {
        return orderRepository.findByUser(user);
    }

    public Optional<Order> fetchOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public List<Order> fetchOrdersByUser(User user) {
        return this.orderRepository.findByUser(user);
    }

    // ================== CREATE ==================
    public Order saveOrder(Order order) {
        return this.orderRepository.save(order);
    }

    // ================== UPDATE ==================
    public void updateOrder(Order order) {
        Optional<Order> optionalOrder = this.fetchOrderById(order.getId());

        if (optionalOrder.isPresent()) {
            Order currentOrder = optionalOrder.get();

            currentOrder.setStatus(order.getStatus());
            currentOrder.setPaymentMethod(order.getPaymentMethod());
            currentOrder.setNote(order.getNote());
            currentOrder.setTotalPrice(order.getTotalPrice());

            this.orderRepository.save(currentOrder);
        }
    }

    // ================== DELETE ==================
    public void deleteOrderById(long id) {
        Optional<Order> optionalOrder = this.fetchOrderById(id);

        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();

            List<OrderDetail> orderDetails = order.getOrderDetails();
            if (orderDetails != null) {
                for (OrderDetail orderDetail : orderDetails) {
                    this.orderDetailRepository.deleteById(orderDetail.getId());
                }
            }

            this.orderRepository.deleteById(id);
        }
    }

}
