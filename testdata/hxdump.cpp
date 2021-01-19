/*
 * Copyright (c) 2021, Marcos Medeiros
 * Licensed under BSD 3-clause.
 */
#include <iostream>
#include <cstdio>
#include <cstdint>

int main(int argc, char *argv[])
{
    if (argc < 3) {
        std::cout << "hxdump <input> <output>" << std::endl;
        return 1;
    }

    FILE* fp = nullptr;
    errno_t err;
    err = fopen_s(&fp, argv[1], "rb");
    if (err != 0) {
        std::cout << argv[1] << " failed to open" << std::endl;
        return 1;
    }
    fseek(fp, 0, SEEK_END);
    size_t size = ftell(fp);
    fseek(fp, 0, SEEK_SET);

    if (size == 0) {
        std::cout << "Empty file" << std::endl;
        return 1;
    }

    FILE* wf = nullptr;
    err = fopen_s(&wf, argv[2], "w");
    if (err != 0) {
        std::cout << argv[2] << " failed to open" << std::endl;
        return 1;
    }

    size_t pad = size % 4;
    size += pad;

    size_t dwords = size / 4;
    int32_t* buffer = new int32_t[dwords];
    memset(buffer, 0, size);
    fread(buffer, 1, size, fp);

    std::cout << "Dumping " << dwords << " dwords..." << std::endl;
    for (size_t i = 0; i < dwords; i++) {
        fprintf(wf, "%08X\n", buffer[i]);
    }
    fclose(wf);
    fclose(fp);

    delete[] buffer;

    return 0;
}

