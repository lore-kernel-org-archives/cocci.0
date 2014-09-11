From: picca@synchrotron-soleil.fr (picca at synchrotron-soleil.fr)
Date: Thu, 11 Sep 2014 16:27:37 +0200
Subject: [Cocci] how to add a few decalrations
In-Reply-To: <alpine.DEB.2.10.1409111614550.2419@hadrien>
References: <20140911121635.GA23610@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111513080.2419@hadrien>
 <20140911134530.GA7006@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111550170.2419@hadrien>
 <20140911140325.GA7341@synchrotron-soleil.fr>
 <20140911141340.GA7418@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111614550.2419@hadrien>
Message-ID: <20140911142737.GA7480@synchrotron-soleil.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Sep 11, 2014 at 04:16:09PM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 11 Sep 2014, picca at synchrotron-soleil.fr wrote:
> 
> > > {
> > >         int res = TRUE;
> > >         HklEngineList *engines;
> > >         HklEngine *engine;
> > >         const HklFactory *factory;
> > >         HklGeometry *geometry;
> > >         HklDetector *detector;
> > >         HklSample *sample;
> > >
> > >         factory = hkl_factory_get_by_name("E6C", NULL);
> > >         geometry = hkl_factory_create_new_geometry(factory);
> > >         sample = hkl_sample_new("test");
> > >
> > >         detector = hkl_detector_factory_new(HKL_DETECTOR_TYPE_0D);
> > >
> > >         engines = hkl_factory_create_new_engine_list(factory);
> > >         hkl_engine_list_init(engines, geometry, detector, sample);
> > >
> > >         engine = hkl_engine_list_engine_get_by_name(engines, "hkl", NULL);
> > >
> > >         /* geometry -> pseudo */
> > >         hkl_geometry_set_values_v(geometry, HKL_UNIT_USER, NULL, 0., 30., 0., 0., 0., 60.);
> >
> > re-reading the code I realize that I need to do transformation like this
> > ... (vaargs) -> double values[] = { ... (values) ...};
> >
> >
> > is it possible ?
> I'm not completely sure to understand.  Perhaps send an example of the
> code you have and want to produce.

I take the previous line and I want 

f(
...

/* for each */
  hkl_geometry_set_values_v(geometry, HKL_UNIT_USER, NULL, 0., 30., 0., 0., 0., 60.);

...
)

->

f{
+ unsigned int n_values; /* only once it is identical for all the set_v methods */
...
geometry = hkl_factory_create_new_geometry(factory); /* initialisation of geometry */
+ n_values = darray_size(*hkl_engine_geometry_axes_names_get(geometry));

...

/* for each */
{
double values[n_values] = {0., 30., 0., 0., 0., 60.};
hkl_geometry_axes_values_set(geometry, values, n_values, HKl_UNIT_USER, NULL);
}

> But the more immediate problem is that your pattern has &error and you
> code always has NULL in that position.  Do you want to generalize the
> pattern (eg expression error;) or do you want to try some other code?

Yes the error is a GError** or NULL;

is it clearer ?

Frederic
