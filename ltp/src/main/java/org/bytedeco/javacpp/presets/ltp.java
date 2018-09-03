package org.bytedeco.javacpp.presets;

import org.bytedeco.javacpp.ClassProperties;
import org.bytedeco.javacpp.LoadEnabled;
import org.bytedeco.javacpp.annotation.Platform;
import org.bytedeco.javacpp.annotation.Properties;
import org.bytedeco.javacpp.tools.Info;
import org.bytedeco.javacpp.tools.InfoMap;
import org.bytedeco.javacpp.tools.InfoMapper;

/**
 * Copyright @2018 R&D, NTC Inc. (ntc.ai)
 * <p>
 * Author: eric.x.sun <eric.x.sun@gmail.com>
 */

@Properties(target = "org.bytedeco.javacpp.ltp", value = {
    @Platform(
        value = { "linux", "macosx" },
        compiler = { "cpp11" },
        include = { "ltp/segment_dll.h", "ltp/postag_dll.h", "ltp/ner_dll.h", "ltp/parser_dll.h" },
        link = {"segmentor", "postagger", "ner", "parser"}) })
public class ltp implements InfoMapper {
    public void map(InfoMap infoMap) {
        infoMap
            .put(new Info("void *", "void*").valueTypes("Pointer"))
            .put(new Info("std::vector<std::string>").pointerTypes("StringVector").define())
            .put(new Info("std::vector<int>").pointerTypes("IntVector").define());
    }
}
