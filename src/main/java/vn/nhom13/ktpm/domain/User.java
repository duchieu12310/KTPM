package vn.nhom13.ktpm.domain;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

@Entity
@Table(name = "users")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotNull
    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    private String email;

    @NotNull
    @Size(min = 2, message = "Password phải có tối thiểu 2 ký tự")
    private String password;

    @NotNull
    @Size(min = 3, message = "Họ và tên phải có tối thiểu 3 ký tự")
    @Column(name = "full_name")
    private String fullName;

    // Địa chỉ bắt buộc
    @NotNull(message = "Địa chỉ không được để trống")
    @NotBlank(message = "Địa chỉ không được để trống")
    private String address;

    // Số điện thoại: bắt đầu bằng 0, đúng 10 số, chỉ gồm số
    @NotNull(message = "Số điện thoại không được để trống")
    @Pattern(regexp = "^0\\d{9}$", message = "Số điện thoại phải bắt đầu bằng 0 và gồm đúng 10 chữ số")
    private String phone;

    private String avatar;

    // NAM | NU | KHAC
    @NotNull(message = "Giới tính không được để trống")
    @Pattern(regexp = "NAM|NU|KHAC", message = "Giới tính phải là NAM, NU hoặc KHAC")
    private String gender;

    // Năm sinh từ 1924 đến 2024
    @NotNull(message = "Năm sinh không được để trống")
    @Min(value = 1924, message = "Năm sinh phải từ 1924 trở lên")
    @Max(value = 2024, message = "Năm sinh không được lớn hơn 2024")
    @Column(name = "birth_year")
    private Integer birthYear;

    // User many -> one -> Role
    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;

    @OneToMany(mappedBy = "user")
    private List<Order> orders;

    @OneToOne(mappedBy = "user")
    private Cart cart;

    // ================= GETTER & SETTER =================

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Integer getBirthYear() {
        return birthYear;
    }

    public void setBirthYear(Integer birthYear) {
        this.birthYear = birthYear;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    @Override
    public String toString() {
        return "User [id=" + id
                + ", email=" + email
                + ", fullName=" + fullName
                + ", phone=" + phone
                + ", gender=" + gender
                + ", birthYear=" + birthYear + "]";
    }
}
