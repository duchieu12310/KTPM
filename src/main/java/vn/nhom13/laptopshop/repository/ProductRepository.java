package vn.nhom13.laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

import vn.nhom13.laptopshop.domain.Factory;
import vn.nhom13.laptopshop.domain.Product;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long>, JpaSpecificationExecutor<Product> {
    Page<Product> findAll(Pageable page);

    Page<Product> findAll(Specification<Product> spec, Pageable page);

    List<Product> findByFactory(Factory factory);

    // Lấy danh sách product theo factory id
    List<Product> findByFactory_Id(long factoryId);

    // Tìm product theo tên (ví dụ dùng cho search)
    List<Product> findByNameContainingIgnoreCase(String name);
}
