package com.lol.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.lol.Service.ChampionService;
import com.lol.vo.ChampDTO;

@Controller
public class ChampionController {

  @Autowired
  private ChampionService championService;

  @GetMapping("/championImages")
  public String getChampionImages(Model model) {

    List<ChampDTO.Champion> champions = championService.getChampions();
    model.addAttribute("champions", champions);

    return "championImages";
  }

}

