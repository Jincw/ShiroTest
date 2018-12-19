package com.jcw.service.impl;

import com.jcw.mapper.FileMapper;
import com.jcw.service.FileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FileServiceImpl implements FileService {
    @Autowired
    FileMapper fileMapper;
}
