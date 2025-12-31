package vn.nhom13.ktpm.controller.admin;

import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.nhom13.ktpm.domain.Factory;
import vn.nhom13.ktpm.service.FactoryService;
import jakarta.validation.Valid;
import org.springframework.validation.BindingResult;

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
    public String handleCreateFactory(
            @Valid @ModelAttribute("newFactory") Factory factory,
            BindingResult result,
            Model model) {

        // 1. Check validate (trống dữ liệu)
        if (result.hasErrors()) {
            return "admin/factory/create";
        }

        // 2. Check trùng ID
        if (factoryService.fetchFactoryById(factory.getId()).isPresent()) {
            model.addAttribute("error", "Factory ID đã tồn tại, vui lòng nhập ID khác");
            return "admin/factory/create";
        }

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
    public String handleUpdateFactory(
            @Valid @ModelAttribute("newFactory") Factory factory,
            BindingResult result) {

        if (result.hasErrors()) {
            return "admin/factory/update";
        }

        factoryService.createFactory(factory); // save/update
        return "redirect:/admin/factory";
    }

    // ================= DELETE =================
    @GetMapping("/delete/{id}")
    public String deleteFactory(
            @PathVariable long id,
            RedirectAttributes redirectAttributes) {

        try {
            factoryService.deleteFactory(id);
            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Xóa factory thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    "Không thể xóa factory vì đã có sản phẩm!");
        }

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
