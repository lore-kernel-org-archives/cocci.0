From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Sep 2014 16:16:09 +0200 (CEST)
Subject: [Cocci] how to add a few decalrations
In-Reply-To: <20140911141340.GA7418@synchrotron-soleil.fr>
References: <20140911121635.GA23610@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111513080.2419@hadrien>
 <20140911134530.GA7006@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111550170.2419@hadrien>
 <20140911140325.GA7341@synchrotron-soleil.fr>
 <20140911141340.GA7418@synchrotron-soleil.fr>
Message-ID: <alpine.DEB.2.10.1409111614550.2419@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 11 Sep 2014, picca at synchrotron-soleil.fr wrote:

> > {
> >         int res = TRUE;
> >         HklEngineList *engines;
> >         HklEngine *engine;
> >         const HklFactory *factory;
> >         HklGeometry *geometry;
> >         HklDetector *detector;
> >         HklSample *sample;
> >
> >         factory = hkl_factory_get_by_name("E6C", NULL);
> >         geometry = hkl_factory_create_new_geometry(factory);
> >         sample = hkl_sample_new("test");
> >
> >         detector = hkl_detector_factory_new(HKL_DETECTOR_TYPE_0D);
> >
> >         engines = hkl_factory_create_new_engine_list(factory);
> >         hkl_engine_list_init(engines, geometry, detector, sample);
> >
> >         engine = hkl_engine_list_engine_get_by_name(engines, "hkl", NULL);
> >
> >         /* geometry -> pseudo */
> >         hkl_geometry_set_values_v(geometry, HKL_UNIT_USER, NULL, 0., 30., 0., 0., 0., 60.);
>
> re-reading the code I realize that I need to do transformation like this
> ... (vaargs) -> double values[] = { ... (values) ...};
>
>
> is it possible ?
I'm not completely sure to understand.  Perhaps send an example of the
code you have and want to produce.

But the more immediate problem is that your pattern has &error and you
code always has NULL in that position.  Do you want to generalize the
pattern (eg expression error;) or do you want to try some other code?

julia
