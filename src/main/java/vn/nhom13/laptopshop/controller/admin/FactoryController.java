package vn.nhom13.laptopshop.controller.admin;

import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import vn.nhom13.laptopshop.domain.Factory;
import vn.nhom13.laptopshop.service.FactoryService;

@Controller
@RequestMapping("/admin/factory")
public class FactoryController {

    private final FactoryService factoryService;

    public FactoryController(FactoryService factoryService) {
        this.factoryService = factoryService;
    }

    // ================= LIST =================
    @GetMapping
    public String showFactory(Model model) {
        model.addAttribute("factories", factoryService.fetchAllFactories());
        return "admin/factory/show";
    }

    // ================= CREATE =================
    @GetMapping("/create")
    public String getCreateFactoryPage(Model model) {
        model.addAttribute("newFactory", new Factory());
        return "admin/factory/create";
    }

    @PostMapping("/create")
    public String handleCreateFactory(@ModelAttribute("newFactory") Factory factory) {
        factoryService.createFactory(factory);
        return "redirect:/admin/factory";
    }

    // ================= UPDATE (GET) =================
    @GetMapping("/update/{id}")
    public String getUpdateFactoryPage(Model model, @PathVariable long id) {

        Optional<Factory> factoryOpt = factoryService.fetchFactoryById(id);
        if (factoryOpt.isEmpty()) {
            return "redirect:/admin/factory";
        }

        model.addAttribute("newFactory", factoryOpt.get());
        return "admin/factory/update";
    }

    // ================= UPDATE (POST) =================
    @PostMapping("/update")
    public String handleUpdateFactory(@ModelAttribute("newFactory") Factory factory) {
        factoryService.createFactory(factory); // save/update
        return "redirect:/admin/factory";
    }

    // ================= DELETE =================
    @GetMapping("/delete/{id}")
    public String deleteFactory(@PathVariable long id) {
        factoryService.deleteFactory(id);
        return "redirect:/admin/factory";
    }

    // ================= DETAIL =================
    @GetMapping("/{id}")
    public String getFactoryDetail(Model model, @PathVariable long id) {

        Optional<Factory> factoryOpt = factoryService.fetchFactoryById(id);
        if (factoryOpt.isEmpty()) {
            return "redirect:/admin/factory";
        }

        model.addAttribute("factory", factoryOpt.get());
        return "admin/factory/detail";
    }
}
