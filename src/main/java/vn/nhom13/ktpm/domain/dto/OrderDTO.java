package vn.nhom13.ktpm.domain.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public class OrderDTO {

    @NotBlank(message = "Họ và Tên không được để trống")
    @Size(min = 3, message = "Họ và tên phải có tối thiểu 3 ký tự")
    private String receiverName;

    @NotBlank(message = "Địa chỉ không được để trống")
    @Size(min = 5, message = "Địa chỉ phải có ít nhất 5 ký tự")
    private String receiverAddress;

    @NotBlank(message = "Số điện thoại không được để trống")
    @Pattern(regexp = "^0\\d{9}$", message = "Số điện thoại phải bắt đầu bằng 0 và gồm đúng 10 chữ số")
    private String receiverPhone;

    private String note; // ghi chú, có thể để trống

    // GETTERS & SETTERS
    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(String receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
