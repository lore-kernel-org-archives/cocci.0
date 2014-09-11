From: picca@synchrotron-soleil.fr (picca at synchrotron-soleil.fr)
Date: Thu, 11 Sep 2014 16:13:40 +0200
Subject: [Cocci] how to add a few decalrations
In-Reply-To: <20140911140325.GA7341@synchrotron-soleil.fr>
References: <20140911121635.GA23610@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111513080.2419@hadrien>
 <20140911134530.GA7006@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111550170.2419@hadrien>
 <20140911140325.GA7341@synchrotron-soleil.fr>
Message-ID: <20140911141340.GA7418@synchrotron-soleil.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> {
>         int res = TRUE;
>         HklEngineList *engines;
>         HklEngine *engine;
>         const HklFactory *factory;
>         HklGeometry *geometry;
>         HklDetector *detector;
>         HklSample *sample;
> 
>         factory = hkl_factory_get_by_name("E6C", NULL);
>         geometry = hkl_factory_create_new_geometry(factory);
>         sample = hkl_sample_new("test");
> 
>         detector = hkl_detector_factory_new(HKL_DETECTOR_TYPE_0D);
> 
>         engines = hkl_factory_create_new_engine_list(factory);
>         hkl_engine_list_init(engines, geometry, detector, sample);
> 
>         engine = hkl_engine_list_engine_get_by_name(engines, "hkl", NULL);
> 
>         /* geometry -> pseudo */
>         hkl_geometry_set_values_v(geometry, HKL_UNIT_USER, NULL, 0., 30., 0., 0., 0., 60.);

re-reading the code I realize that I need to do transformation like this
... (vaargs) -> double values[] = { ... (values) ...};


is it possible ?
