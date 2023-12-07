package com.lol.Service;

import java.util.List;
import com.lol.vo.ChampDTO;

public interface ChampionService {
  List<ChampDTO.Champion> getChampions();
}
