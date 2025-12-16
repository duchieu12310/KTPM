package vn.nhom13.laptopshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import vn.nhom13.laptopshop.domain.Role;
import vn.nhom13.laptopshop.domain.User;
import vn.nhom13.laptopshop.domain.dto.RegisterDTO;
import vn.nhom13.laptopshop.repository.OrderRepository;
import vn.nhom13.laptopshop.repository.ProductRepository;
import vn.nhom13.laptopshop.repository.RoleRepository;
import vn.nhom13.laptopshop.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;

    public UserService(
            UserRepository userRepository,
            RoleRepository roleRepository,
            ProductRepository productRepository,
            OrderRepository orderRepository) {

        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.productRepository = productRepository;
        this.orderRepository = orderRepository;
    }

    // ================= USER =================

    public Page<User> getAllUsers(Pageable page) {
        return this.userRepository.findAll(page);
    }

    public User getCurrentUser() {
        Object principal = SecurityContextHolder.getContext()
                .getAuthentication()
                .getPrincipal();

        if (principal instanceof User) {
            return (User) principal;
        }

        return null;
    }

    public List<User> getAllUsersByEmail(String email) {
        return this.userRepository.findOneByEmail(email);
    }

    public User getUserById(long id) {
        return this.userRepository.findById(id);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    public User handleSaveUser(User user) {
        User savedUser = this.userRepository.save(user);
        System.out.println(savedUser);
        return savedUser;
    }

    public void deleteAUser(long id) {
        this.userRepository.deleteById(id);
    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

    // ================= ROLE =================

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    // ================= REGISTER =================

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();

        // Full name
        user.setFullName(
                registerDTO.getFirstName().trim() + " " +
                        registerDTO.getLastName().trim());

        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());

        // Field mới
        user.setPhone(registerDTO.getPhone());
        user.setGender(registerDTO.getGender());
        user.setBirthYear(registerDTO.getBirthYear());
        user.setAddress(registerDTO.getAddress());
        // Role mặc định USER
        Role role = this.roleRepository.findByName("USER");
        user.setRole(role);

        return user;
    }

    // ================= DASHBOARD =================

    public long countUsers() {
        return this.userRepository.count();
    }

    public long countProducts() {
        return this.productRepository.count();
    }

    public long countOrders() {
        return this.orderRepository.count();
    }
}
