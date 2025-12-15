package vn.nhom13.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.nhom13.laptopshop.domain.Factory;

@Repository
public interface FactoryRepository extends JpaRepository<Factory, Long> {

    // Tìm factory theo tên
    Factory findByName(String name);

    // Kiểm tra factory đã tồn tại chưa
    boolean existsByName(String name);
}
