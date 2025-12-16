package vn.nhom13.ktpm.domain.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import vn.nhom13.ktpm.service.validator.RegisterChecked;
import jakarta.validation.constraints.Min;

@RegisterChecked
public class RegisterDTO {

    @NotBlank(message = "First name không được để trống")
    @Size(min = 3, message = "First name phải có tối thiểu 3 ký tự")
    private String firstName;

    private String lastName;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không hợp lệ", regexp = "^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$")
    private String email;

    @NotBlank(message = "Số điện thoại không được để trống")
    private String phone;

    // NAM | NU | KHAC
    @NotBlank(message = "Vui lòng chọn giới tính")
    private String gender;

    @NotNull(message = "Năm sinh không được để trống")
    @Min(value = 1900, message = "Năm sinh không hợp lệ")
    private Integer birthYear;

    @NotBlank(message = "Địa chỉ không được để trống")
    @Size(min = 5, message = "Địa chỉ phải có ít nhất 5 ký tự")
    private String address;

    @NotBlank(message = "Password không được để trống")
    @Size(min = 3, message = "Password phải có tối thiểu 3 ký tự")
    private String password;

    @NotBlank(message = "Confirm password không được để trống")
    @Size(min = 3, message = "Confirm password phải có tối thiểu 3 ký tự")
    private String confirmPassword;

    /* ================= GETTER & SETTER ================= */

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }
}
