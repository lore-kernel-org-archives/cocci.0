From: picca@synchrotron-soleil.fr (picca at synchrotron-soleil.fr)
Date: Thu, 11 Sep 2014 16:03:25 +0200
Subject: [Cocci] how to add a few decalrations
In-Reply-To: <alpine.DEB.2.10.1409111550170.2419@hadrien>
References: <20140911121635.GA23610@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111513080.2419@hadrien>
 <20140911134530.GA7006@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111550170.2419@hadrien>
Message-ID: <20140911140325.GA7341@synchrotron-soleil.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> OK, it seems that it is trying to add the definitions even if it does not
> have any matches for the part inside the <... ...>.  <... ...> eans 0 or
> more.  Try changing it to <+... ...+>, which means at least one.

with this modification I have no error, but I have also no transformation.

Here I put an exemple of method where I want to do the transformation

static void getter(void)
{
        int res = TRUE;
        HklEngineList *engines;
        HklEngine *engine;
        const HklFactory *factory;
        HklGeometry *geometry;
        HklDetector *detector;
        HklSample *sample;

        factory = hkl_factory_get_by_name("E6C", NULL);
        geometry = hkl_factory_create_new_geometry(factory);
        sample = hkl_sample_new("test");

        detector = hkl_detector_factory_new(HKL_DETECTOR_TYPE_0D);

        engines = hkl_factory_create_new_engine_list(factory);
        hkl_engine_list_init(engines, geometry, detector, sample);

        engine = hkl_engine_list_engine_get_by_name(engines, "hkl", NULL);

        /* geometry -> pseudo */
        hkl_geometry_set_values_v(geometry, HKL_UNIT_USER, NULL, 0., 30., 0., 0., 0., 60.);
        res &= DIAG(check_pseudoaxes_v(engine, 0., 0., 1.));

        hkl_geometry_set_values_v(geometry, HKL_UNIT_USER, NULL, 0., 30., 0., 90., 0., 60.);
        res &= DIAG(check_pseudoaxes_v(engine, 1., 0., 0.));

        hkl_geometry_set_values_v(geometry, HKL_UNIT_USER, NULL, 0., 30., 0., -90., 0., 60.);
        res &= DIAG(check_pseudoaxes_v(engine, -1., 0., 0.));

        hkl_geometry_set_values_v(geometry, HKL_UNIT_USER, NULL, 0., 30., 0., 180., 0., 60.);
        res &= DIAG(check_pseudoaxes_v(engine, 0., 0., -1.));

        hkl_geometry_set_values_v(geometry, HKL_UNIT_USER, NULL, 0., 45., 0., 135., 0., 90.);
        res &= DIAG(check_pseudoaxes_v(engine, 1., 0., -1.));

        ok(res == TRUE, "getter");

        hkl_engine_list_free(engines);
        hkl_detector_free(detector);
        hkl_sample_free(sample);
        hkl_geometry_free(geometry);
}


to be fare, here is the signature of the method to replace

HKLAPI int hkl_geometry_set_values_v(HklGeometry *self, HklUnitEnum unit_type,
				     GError **error, ...) HKL_ARG_NONNULL(1) HKL_WARN_UNUSED_RESULT;


Frederic
