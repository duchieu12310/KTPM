package vn.nhom13.ktpm.domain.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Max;
import vn.nhom13.ktpm.service.validator.RegisterChecked;

@RegisterChecked
public class RegisterDTO {

    @NotBlank(message = "Họ và Tên không được để trống")
    @Size(min = 3, message = "Họ và tên phải có tối thiểu 3 ký tự")
    private String firstName;

    // Không bắt buộc
    private String lastName;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không hợp lệ")
    @Pattern(regexp = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", message = "Email phải có định dạng ví dụ: abc@gmail.com")
    private String email;

    @NotBlank(message = "Số điện thoại không được để trống")
    @Pattern(regexp = "^0\\d{9}$", message = "Số điện thoại phải bắt đầu bằng 0 và gồm đúng 10 chữ số")
    private String phone;

    // NAM | NU | KHAC
    @NotBlank(message = "Vui lòng chọn giới tính")
    @Pattern(regexp = "NAM|NU|KHAC", message = "Giới tính phải là NAM, NU hoặc KHAC")
    private String gender;

    @NotNull(message = "Năm sinh không được để trống")
    @Min(value = 1924, message = "Năm sinh phải từ 1924 trở lên")
    @Max(value = 2024, message = "Năm sinh không được lớn hơn 2024")
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
