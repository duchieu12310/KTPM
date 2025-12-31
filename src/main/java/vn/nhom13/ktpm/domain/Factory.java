package vn.nhom13.ktpm.domain;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "factories")
public class Factory implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @NotNull(message = "Factory ID không được để trống")
    private Long id;

    @Column(nullable = false, unique = true)
    @NotBlank(message = "Factory Name không được để trống")
    private String name;

    @OneToMany(mappedBy = "factory", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Product> products;

    // getter & setter
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }
}
