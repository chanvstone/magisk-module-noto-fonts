#include "font.h"
#include <string.h>

struct FontConfigRoboto
{
    char *fileName;
    int weightBegin, weightEnd;
    int width;
    int normal, italic;
};

struct FontConfigNoto
{
    char *normalFileName, *italicFileName;
    int weightBegin, weightEnd;
    int width;
};

struct FontConfigCJK
{
    char *sansFileName, *serifFileName;
    int sansWeightBegin, sansWeightEnd;
    int serifWeightBegin, serifWeightEnd;
    int index;
};

void createRoboto(FILE *target, const char *familyName, const struct FontConfigRoboto *config)
{
    // write font config head
    fprintf(target, "    <family name=\"%s\">\n", familyName);

    // write normal font config of each weight
    for (int weight = config->weightBegin; weight <= config->weightEnd; weight += 100)
    {
        fprintf(
            target,
            "        <font weight=\"%d\" style=\"normal\">%s\n            <axis tag=\"wght\" stylevalue=\"%d\" />\n            <axis tag=\"wdth\" stylevalue=\"%d\" />\n            <axis tag=\"ital\" stylevalue=\"%d\" />\n        </font>\n",
            weight,
            config->fileName,
            weight,
            config->width,
            config->normal);
    }

    // write italic font config of each weight
    for (int weight = config->weightBegin; weight <= config->weightEnd; weight += 100)
    {
        fprintf(
            target,
            "        <font weight=\"%d\" style=\"italic\">%s\n            <axis tag=\"wght\" stylevalue=\"%d\" />\n            <axis tag=\"wdth\" stylevalue=\"%d\" />\n            <axis tag=\"ital\" stylevalue=\"%d\" />\n        </font>\n",
            weight,
            config->fileName,
            weight,
            config->width,
            config->italic);
    }

    // write font config tail
    fputs("    </family>\n", target);
}

void createNoto(FILE *target, const char *falimyName, const struct FontConfigNoto *config)
{
    // write font config head
    fprintf(target, "    <family name=\"%s\">\n", falimyName);

    // write normal font config of each weight
    // do not write normal font config if confile.normalFileName is NULL
    if (config->normalFileName != NULL)
    {
        for (int weight = config->weightBegin; weight <= config->weightEnd; weight += 100)
        {
            fprintf(
                target,
                "        <font weight=\"%d\" style=\"normal\">%s\n            <axis tag=\"wght\" stylevalue=\"%d\" />\n            <axis tag=\"wdth\" stylevalue=\"%d\" />\n        </font>\n",
                weight,
                config->normalFileName,
                weight,
                config->width);
        }
    }

    // write italic font config of each weight
    // do not write italic font config if confile.italicFileName is NULL
    if (config->italicFileName != NULL)
    {
        for (int weight = config->weightBegin; weight <= config->weightEnd; weight += 100)
        {
            fprintf(
                target,
                "        <font weight=\"%d\" style=\"italic\">%s\n            <axis tag=\"wght\" stylevalue=\"%d\" />\n            <axis tag=\"wdth\" stylevalue=\"%d\" />\n        </font>\n",
                weight,
                config->italicFileName,
                weight,
                config->width);
        }
    }

    // write font config tail
    fputs("    </family>\n", target);
}

void createNotoCJK(FILE *target, const char *langName, const struct FontConfigCJK *config)
{
    // write font config head
    fprintf(target, "    <family lang=\"%s\">\n", langName);

    // write sans CJK font config of each weight
    // do not write sans CJK font config if confile.sansFileName is NULL
    if (config->sansFileName != NULL)
    {
        for (int weight = config->sansWeightBegin; weight <= config->sansWeightEnd; weight += 100)
        {
            fprintf(
                target,
                "        <font weight=\"%d\" style=\"normal\" index=\"%d\">%s\n            <axis tag=\"wght\" stylevalue=\"%d\" />\n        </font>\n",
                weight,
                config->index,
                config->sansFileName,
                weight);
        }

        // write serif CJK font config of each weight
        // do not write serif CJK font config if confile.sansFileName is NULL
        if (config->serifFileName != NULL)
        {
            for (int weight = config->serifWeightBegin; weight <= config->serifWeightEnd; weight += 100)
            {
                fprintf(
                    target,
                    "        <font weight=\"%d\" style=\"normal\" index=\"%d\" fallbackFor=\"serif\">%s\n            <axis tag=\"wght\" stylevalue=\"%d\" />\n        </font>\n",
                    weight,
                    config->index,
                    config->serifFileName,
                    weight);
            }
        }

        // write font config tail
        fputs("    </family>\n", target);
    }
}

void robotoSansSerif(FILE *target)
{
    const struct FontConfigRoboto config = {
        "Roboto-VF.ttf",
        100, 900,
        100,
        0, 1};
    createRoboto(target, "sans-serif", &config);
}
void robotoSansSerifCondensed(FILE *target)
{
    const struct FontConfigRoboto config = {
        "Roboto-VF.ttf",
        100, 900,
        75,
        0, 1};
    createRoboto(target, "sans-serif-condensed", &config);
}
void notoSansSerif(FILE *target)
{
    const struct FontConfigNoto config = {
        "NotoSans-VF.ttf",
        "NotoSans-Italic-VF.ttf",
        100, 900,
        100};
    createNoto(target, "sans-serif", &config);
}
void notoSansSerifCondensed(FILE *target)
{
    const struct FontConfigNoto config = {
        "NotoSans-VF.ttf",
        "NotoSans-Italic-VF.ttf",
        100, 900,
        75};
    createNoto(target, "sans-serif-condensed", &config);
}
void notoSerif(FILE *target)
{
    const struct FontConfigNoto config = {
        "NotoSerif-VF.ttf",
        "NotoSerif-Italic-VF.ttf",
        100, 900,
        100};
    createNoto(target, "serif", &config);
}
void notoSerifCondensed(FILE *target)
{
    const struct FontConfigNoto config = {
        "NotoSerif-VF.ttf",
        "NotoSerif-Italic-VF.ttf",
        100, 900,
        75};
    createNoto(target, "serif-condensed", &config);
}
void notoSansMonospace(FILE *target)
{
    const struct FontConfigNoto config = {
        "NotoSansMono-VF.ttf",
        NULL,
        100, 900,
        100};
    createNoto(target, "monospace", &config);
}
void notoSansCjkJa(FILE *target)
{
    const struct FontConfigCJK config = {
        "NotoSansCJK-VF.otf.ttc",
        "NotoSerifCJK-VF.otf.ttc",
        100, 900,
        200, 900,
        0};
    createNotoCJK(target, "ja", &config);
}
void notoSansCjkKo(FILE *target)
{
    const struct FontConfigCJK config = {
        "NotoSansCJK-VF.otf.ttc",
        "NotoSerifCJK-VF.otf.ttc",
        100, 900,
        200, 900,
        1};
    createNotoCJK(target, "ko", &config);
}
void notoSansCjkSc(FILE *target)
{
    const struct FontConfigCJK config = {
        "NotoSansCJK-VF.otf.ttc",
        "NotoSerifCJK-VF.otf.ttc",
        100, 900,
        200, 900,
        2};
    createNotoCJK(target, "zh-Hans", &config);
}
void notoSansCjkTc(FILE *target)
{
    const struct FontConfigCJK config = {
        "NotoSansCJK-VF.otf.ttc",
        "NotoSerifCJK-VF.otf.ttc",
        100, 900,
        200, 900,
        3};
    createNotoCJK(target, "zh-Hant,zh-Bopo", &config);
}

// mod
void findAndReplace(FILE *dest, FILE *src, char *search, void writeConfig(FILE *))
{
    char buffer[512];
    while (fgets(buffer, 512, src) == buffer)
    {
        if (strstr(buffer, search) == NULL)
        {
            fputs(buffer, dest);
        }
        else
        {
            while (fgets(buffer, 512, src) == buffer)
            {
                if (strstr(buffer, "</family>") != NULL)
                {
                    break;
                }
            }
            writeConfig(dest);
            return;
        }
    }
}

void sansSerif(FILE *dest, FILE *src)
{
    findAndReplace(dest, src, "<family name=\"sans-serif\">", robotoSansSerif);
    findAndReplace(dest, src, "<family name=\"sans-serif-condensed\">", robotoSansSerifCondensed);
}

void serif(FILE *dest, FILE *src)
{
    findAndReplace(dest, src, "<family name=\"serif\">", notoSerif);
    notoSerifCondensed(dest);
}

void monospace(FILE *dest, FILE *src)
{
    findAndReplace(dest, src, "<family name=\"monospace\">", notoSansMonospace);
}

void cjk(FILE *dest, FILE *src)
{
    findAndReplace(dest, src, "<family lang=\"zh-Hans\">", notoSansCjkSc);
    findAndReplace(dest, src, "<family lang=\"zh-Hant,zh-Bopo\">", notoSansCjkTc);
    findAndReplace(dest, src, "<family lang=\"ja\">", notoSansCjkJa);
    findAndReplace(dest, src, "<family lang=\"ko\">", notoSansCjkKo);
}

void mod(FILE *dest, FILE *src)
{
    sansSerif(dest, src);
    serif(dest, src);
    monospace(dest, src);
    cjk(dest, src);
    char buffer[512];
    while (fgets(buffer, 512, src) == buffer)
    {
        fputs(buffer, dest);
    }
}
