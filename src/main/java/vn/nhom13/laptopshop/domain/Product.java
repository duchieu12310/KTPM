package vn.nhom13.laptopshop.domain;

import java.io.Serializable;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

@Entity
@Table(name = "products")
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotEmpty(message = "Tên sản phẩm không được để trống")
    private String name;

    @DecimalMin(value = "0", inclusive = false, message = "Giá phải lớn hơn 0")
    private double price;

    private String image;

    @NotEmpty(message = "Mô tả chi tiết không được để trống")
    @Column(columnDefinition = "MEDIUMTEXT")
    private String detailDesc;

    @NotEmpty(message = "Mô tả ngắn không được để trống")
    private String shortDesc;

    @Min(value = 1, message = "Số lượng phải >= 1")
    private long quantity;

    private long sold;

    private String target;

    // ===== QUAN HỆ MANY TO ONE =====
    @ManyToOne
    @JoinColumn(name = "factory_id", nullable = false)
    private Factory factory;

    // ===== FIELD DÙNG CHO FORM =====
    @Transient
    private Long factoryId;

    // ===== GETTER / SETTER =====
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDetailDesc() {
        return detailDesc;
    }

    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public long getSold() {
        return sold;
    }

    public void setSold(long sold) {
        this.sold = sold;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public Factory getFactory() {
        return factory;
    }

    public void setFactory(Factory factory) {
        this.factory = factory;
    }

    public Long getFactoryId() {
        return factoryId;
    }

    public void setFactoryId(Long factoryId) {
        this.factoryId = factoryId;
    }
}
