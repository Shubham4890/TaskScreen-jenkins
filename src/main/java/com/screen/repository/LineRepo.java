package com.screen.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.screen.entity.Line;

public interface LineRepo extends JpaRepository<Line, Long> {
 List<Line> findByLineNameContainingIgnoreCase(String term);
 
 public Line findByLineName(String lineName);
}