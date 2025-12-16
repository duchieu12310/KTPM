package vn.nhom13.ktpm.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import vn.nhom13.ktpm.domain.Factory;
import vn.nhom13.ktpm.repository.FactoryRepository;

@Service
public class FactoryService {

    private final FactoryRepository factoryRepository;

    public FactoryService(FactoryRepository factoryRepository) {
        this.factoryRepository = factoryRepository;
    }

    public Factory createFactory(Factory factory) {
        return this.factoryRepository.save(factory);
    }

    public List<Factory> fetchAllFactories() {
        return this.factoryRepository.findAll();
    }

    public Optional<Factory> fetchFactoryById(long id) {
        return this.factoryRepository.findById(id);
    }

    public Factory fetchFactoryByName(String name) {
        return this.factoryRepository.findByName(name);
    }

    public boolean existsByName(String name) {
        return this.factoryRepository.existsByName(name);
    }

    public void deleteFactory(long id) {
        this.factoryRepository.deleteById(id);
    }
}
