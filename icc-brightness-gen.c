/*
 * Copyright 2017 by Udi Fuchs
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <lcms2.h>


cmsHPROFILE create_srgb_profile(double brightness)
{
    cmsHPROFILE hsRGB = cmsCreate_sRGBProfile();

    cmsMLU *mlu = cmsMLUalloc(NULL, 1);
    char description[20];
    snprintf(description, 20, "Brightness %.2f", brightness);
    cmsMLUsetASCII(mlu, "en", "US", description);
    cmsWriteTag(hsRGB, cmsSigProfileDescriptionTag, mlu);
    cmsMLUfree(mlu);

    cmsContext context_id = cmsCreateContext(NULL, NULL);
    double curve[] = {1.0, brightness, 0.0}; // gamma, a, b for (a X +b)^gamma
    cmsToneCurve *tone_curve[3] = {
	    cmsBuildParametricToneCurve(context_id, 2, curve),
	    cmsBuildParametricToneCurve(context_id, 2, curve),
	    cmsBuildParametricToneCurve(context_id, 2, curve),
    };
    cmsWriteTag(hsRGB, cmsSigVcgtTag, tone_curve);
    cmsFreeToneCurve(tone_curve[0]);
    cmsFreeToneCurve(tone_curve[1]);
    cmsFreeToneCurve(tone_curve[2]);

    return hsRGB;
}

int main(int argc, const char *argv[]) {
    if (argc == 4 &&
        strspn(argv[2], "0123456789") == strlen(argv[2]) &&
        strspn(argv[3], "0123456789") == strlen(argv[3])) {

        const char *filename = argv[1];
        int brightness = atoi(argv[2]);
        int max_brightness = atoi(argv[3]);
	double ratio = (double)brightness / max_brightness;
    	cmsHPROFILE hsRGB = create_srgb_profile(ratio);
    	cmsSaveProfileToFile(hsRGB, filename);
        return 0;
    }
    fprintf(stderr, "%s filename brightness max-brightness\n", argv[0]);
    fprintf(stderr, "brightness and max-brightness must be integers.\n");
    return 1;
}
