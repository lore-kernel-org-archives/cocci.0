From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 23 Dec 2016 16:54:41 +0100 (CET)
Subject: [Cocci] Converting DEVICE_ATTR to DEVICE_ATTR_{RO, RW,
 WO} and changing function names at the same time
In-Reply-To: <20161222181948.GA20516@roeck-us.net>
References: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
 <alpine.DEB.2.20.1612211434221.3084@hadrien>
 <20161221162926.GB6188@roeck-us.net>
 <alpine.DEB.2.20.1612212039090.2005@hadrien>
 <20161221214425.GA2315@roeck-us.net>
 <alpine.DEB.2.20.1612221326060.14381@hadrien>
 <83039af2-7b45-8b1f-d842-85a70b71ba11@roeck-us.net>
 <alpine.DEB.2.20.1612221634440.7817@hadrien>
 <20161222181948.GA20516@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1612231404050.4056@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > > Anyway, for SENSOR_DEVICE_ATTR(), I'll have to be a bit more flexible since
> > > the function _will_ be reused. I'll need something like
> > > 	SENSOR_DEVICE_ATTR_{RO,RW,WO}(attr, func, param)
> >
> > Chosen at random,
> >
> > static SENSOR_DEVICE_ATTR_2(sf2_point4_fan1, S_IRUGO | S_IWUSR,
> >                         show_sf2_point, store_sf2_point, 4, 1);
> >
> > should become
> >
> > static SENSOR_DEVICE_ATTR_2_RW(sf2_point4_fan1, sf2_point, 4, 1); ?
> >
> > And the functions should be renamed with show and store at the end?
> >
> Yes, exactly.  Of course, not all of them use "show_" at the beginning.
> get_ and set_ are used as well. Essentially I would want to replace
> 	[driver_prefix]{show_,get_,set_}func{_get,_show,_set}
> with 'func'.
>
> If you have an idea how to do that, any hints would be welcome.

Below there is a semantic patch that attempts to do the above and the
output on the entire Linux kernel.  Let me know if it looks reasonable.  In
particular, there is the choice of function name.  I keep the driver_prefix
part, because if I drop it, there is a risk of multiple functions getting
the same name.  The RW case poses a problem too, because the read and write
names have to end up the same.  I don't do the transformation if they are
different.  Another approach would be to derive the _show name as above and
just replace the store name with the corresponding _store version.

I made some dummy definitions of the macros and tried compiling the result.
The following files did not compile:

drivers/hwmon/s3c-hwmon.o
drivers/hwmon/ultra45_env.o
drivers/hwmon/wm831x-hwmon.o
drivers/platform/mips/cpu_hwmon.o

s3c-hwmon and cpu_hwmon don't compile for x86.  ultra45_env and
wm831x-hwmon have SENSOR_DEVICE_ATTR call in macros that Coccinelle is not
able to parse. So those calls don't get updated properly.

> > > Maybe Greg would be open to something like
> > > DEVICE_ATTR_FUNC_{RO,RW,WO}(attr,func)
> > > to accommodate the "I want my own function name" crowd ? That would also solve
> > > the case where the function is reused for multiple attributes.
> >
> > Actually, it was the DEVICE_ATTR_{RO,RW,WO} that wasn't liked.  It doesn't
> > show the exact permission numbers.  The fact that not all DEVICE_ATTR uses
>
>
> It should be obvious that using the {RO,RW,WO} variants is less error prone.
> Can anyone seriously argue against that ?


The comment was:

---

https://lkml.org/lkml/2016/11/14/832
I applied this to pci/aspm to follow the herd, although it looks
pretty similar to the ill-fated "Replace numeric parameter like 0444
with macro" series (http://lwn.net/Articles/696229/).  Maybe this is
different because everybody except me knows what ATTR_RW means?  To
me, "0644" contained more information than "_RW" does.

---

Perhaps it is a passing personal preference rather than a determined opposition.

I looked at some of the DEVICE_ATTR cases that are not being changed.  Some
are related to the # issue, some to the requirement that the show and store
functions be static to allow renaming, and some to non-standard
permissions, such as 0660 0440 0600 0400 etc.  And the issue of function
names that are reused.  Would it be worthwhile to intrroduce eg
DEVICE_ATTR2_RO or DEVICE_ATTR_FUNC_RO to allow specifying a function name
in those cases?  Or is it just as well to leave them as raw DEVICE_ATTR
calls?

julia

------------------------------------------------------------------------

@initialize:ocaml@
@@

let same_length(s1,s2) = String.length s1 = String.length s2

let unshow s =
  match Str.split_delim (Str.regexp "show_") s with
    ["";aft] -> aft
  | [bef;aft] -> bef ^ aft
  | _ ->
      match Str.split_delim (Str.regexp "get_") s with
	["";aft] -> aft
      | [bef;aft] -> bef ^ aft
      | _ ->
	  match List.rev (Str.split_delim (Str.regexp "_") s) with
	    ("show"|"get")::rest -> String.concat "_" (List.rev rest)
	  | _ -> s

let unstore s =
  match Str.split_delim (Str.regexp "store_") s with
    ["";aft] -> aft
  | [bef;aft] -> bef ^ aft
  | _ ->
      match Str.split_delim (Str.regexp "set_") s with
	["";aft] -> aft
      | [bef;aft] -> bef ^ aft
      | _ ->
	  match List.rev (Str.split_delim (Str.regexp "_") s) with
	    ("store"|"set")::rest -> String.concat "_" (List.rev rest)
	  | _ -> s

let unshow_check s model =
  match List.rev (Str.split (Str.regexp "_") s) with
    "show"::rest ->
      let required = String.concat "_" (List.rev rest) in
      if required = model then "" else required
  | _ -> "" (*matches no identifier*)

let unstore_check s model =
  match List.rev (Str.split (Str.regexp "_") s) with
    "store"::rest ->
      let required = String.concat "_" (List.rev rest) in
      if required = model then "" else required
  | _ -> "" (*matches no identifier*)

// -------------------------------------------------------------------------
@ro@
declarer name SENSOR_DEVICE_ATTR, SENSOR_DEVICE_ATTR_2;
identifier x,show;
@@

\(SENSOR_DEVICE_ATTR\|SENSOR_DEVICE_ATTR_2\)
        (x, \(0444\|S_IRUGO\), show, NULL, ...);

@script:ocaml rof@
show << ro.show;
rofunc;
rofunc2;
show_check;
@@

let f = unshow (show : string) in
rofunc := make_ident f;
rofunc2 := make_ident (f ^ "_show");
show_check := make_ident(unshow_check show f)

@fixed_ro@
declarer name SENSOR_DEVICE_ATTR_RO, SENSOR_DEVICE_ATTR_2_RO,
SENSOR_DEVICE_ATTR_WO, SENSOR_DEVICE_ATTR_2_WO,
SENSOR_DEVICE_ATTR_RW, SENSOR_DEVICE_ATTR_2_RW,
DEVICE_ATTR_RO,DEVICE_ATTR_WO,DEVICE_ATTR_RW;
identifier rof.show_check;
expression e;
@@

(
\(DEVICE_ATTR_RO\|DEVICE_ATTR_WO\|DEVICE_ATTR_RW\)(show_check,...);
|
\(SENSOR_DEVICE_ATTR_RO\|SENSOR_DEVICE_ATTR_WO\|SENSOR_DEVICE_ATTR_RW\|
  SENSOR_DEVICE_ATTR_2_RO\|SENSOR_DEVICE_ATTR_2_WO\|SENSOR_DEVICE_ATTR_2_RW\)
  (e,show_check,...);
)

@show_ro depends on !fixed_ro@
identifier ro.show : script:ocaml(rof.rofunc2) {same_length(show,rofunc2)};
identifier rof.rofunc2;
@@

static
- show
+ rofunc2
  (...) { ... }

@show_ro_a depends on !show_ro && !fixed_ro@
identifier ro.show, rof.rofunc2;
parameter list ps;
@@

static
- show(ps)
+ rofunc2(ps)
  { ... }

@depends on show_ro || show_ro_a@
identifier ro.show,rof.rofunc2;
expression list es;
@@
- show(es)
+ rofunc2(es)

@depends on show_ro || show_ro_a@
identifier ro.show,rof.rofunc2;
@@
- show
+ rofunc2

@@
identifier ro.x,rof.rofunc,rof.rofunc2;
expression list es;
@@

(
- SENSOR_DEVICE_ATTR
+ SENSOR_DEVICE_ATTR_RO
|
- SENSOR_DEVICE_ATTR_2
+ SENSOR_DEVICE_ATTR_2_RO
)
  (x,
-  \(0444\|S_IRUGO\), rofunc2, NULL,es);
+  rofunc,es);

// -------------------------------------------------------------------------

@wo@
identifier x,store;
@@

\(SENSOR_DEVICE_ATTR\|SENSOR_DEVICE_ATTR_2\)
         (x, \(0200\|S_IWUSR\), NULL, store, ...);

@script:ocaml wof@
store << wo.store;
wofunc;
wofunc2;
store_check;
@@

let f = unstore store in
wofunc := make_ident f; wofunc2 := make_ident(f ^ "_store");
store_check := make_ident(unstore_check store f)

@fixed_wo@
identifier wof.wofunc;
identifier wof.store_check;
expression e;
@@

(
\(DEVICE_ATTR_RO\|DEVICE_ATTR_WO\|DEVICE_ATTR_RW\)(store_check,...);
|
\(SENSOR_DEVICE_ATTR_RO\|SENSOR_DEVICE_ATTR_WO\|SENSOR_DEVICE_ATTR_RW\|
  SENSOR_DEVICE_ATTR_2_RO\|SENSOR_DEVICE_ATTR_2_WO\|SENSOR_DEVICE_ATTR_2_RW\)
  (e,store_check,...);
)

@store_wo depends on !fixed_wo@
identifier wo.store : script:ocaml(wof.wofunc2) {same_length(store,wofunc2)};
identifier wof.wofunc2;
@@

static
- store
+ wofunc2
  (...) { ... }

@store_wo_a depends on !store_wo && !fixed_wo@
identifier wo.store, wof.wofunc2;
parameter list ps;
@@

static
- store(ps)
+ wofunc2(ps)
  { ... }

@depends on store_wo || store_wo_a@
identifier wo.store,wof.wofunc2;
expression list es;
@@
- store(es)
+ wofunc2(es)

@depends on store_wo || store_wo_a@
identifier wo.store,wof.wofunc2;
@@
- store
+ wofunc2

@@
identifier wo.x,wof.wofunc,wof.wofunc2;
expression list es;
@@

(
- SENSOR_DEVICE_ATTR
+ SENSOR_DEVICE_ATTR_WO
|
- SENSOR_DEVICE_ATTR_2
+ SENSOR_DEVICE_ATTR_2_WO
)
  (x,
-  \(0200\|S_IWUSR\), NULL, wofunc2,es);
+  wofunc,es);

// -------------------------------------------------------------------------

@rw@
identifier x,show,store;
@@

\(SENSOR_DEVICE_ATTR\|SENSOR_DEVICE_ATTR_2\)
    (x, \(0644\|S_IRUGO|S_IWUSR\), show, store, ...);

@script:ocaml rwf@
show << rw.show;
store << rw.store;
rwfunc;
rwfunc2_show;
rwfunc2_store;
show_check;
store_check;
@@

let f1 = unshow show in
let f2 = unstore store in
if f1 = f2
then
  begin
    rwfunc := make_ident f1;
    rwfunc2_show := make_ident(f1 ^ "_show");
    rwfunc2_store := make_ident(f1 ^ "_store");
    show_check := make_ident(unshow_check show f1);
    store_check := make_ident(unstore_check store f2)
  end
else Coccilib.include_match false

@fixed_rw@
identifier rwf.show_check,rwf.store_check;
expression e;
@@

(
\(DEVICE_ATTR_RO\|DEVICE_ATTR_WO\|DEVICE_ATTR_RW\)
    (\(show_check\|store_check\),...);
|
\(SENSOR_DEVICE_ATTR_RO\|SENSOR_DEVICE_ATTR_WO\|SENSOR_DEVICE_ATTR_RW\|
  SENSOR_DEVICE_ATTR_2_RO\|SENSOR_DEVICE_ATTR_2_WO\|SENSOR_DEVICE_ATTR_2_RW\)
    (e,\(show_check\|store_check\),...);
)

@show_rw depends on !fixed_rw@
identifier rw.show :
   script:ocaml(rwf.rwfunc2_show) {same_length(show,rwfunc2_show)};
identifier rwf.rwfunc2_show;
@@

static
- show
+ rwfunc2_show
  (...) { ... }

@show_rw_a depends on !show_rw && !fixed_rw@
identifier rw.show, rwf.rwfunc2_show;
parameter list ps;
@@

static
- show(ps)
+ rwfunc2_show(ps)
  { ... }

@depends on show_rw || show_rw_a@
identifier rw.show,rwf.rwfunc2_show;
expression list es;
@@
- show(es)
+ rwfunc2_show(es)

@depends on show_rw || show_rw_a@
identifier rw.show,rwf.rwfunc2_show;
@@
- show
+ rwfunc2_show

@store_rw depends on !fixed_rw@
identifier rw.store :
   script:ocaml(rwf.rwfunc2_store) {same_length(store,rwfunc2_store)};
identifier rwf.rwfunc2_store;
@@

static
- store
+ rwfunc2_store
  (...) { ... }

@store_rw_a depends on !store_rw && !fixed_rw@
identifier rw.store, rwf.rwfunc2_store;
parameter list ps;
@@

static
- store(ps)
+ rwfunc2_store(ps)
  { ... }

@depends on store_rw || store_rw_a@
identifier rw.store,rwf.rwfunc2_store;
expression list es;
@@
- store(es)
+ rwfunc2_store(es)

@depends on store_rw || store_rw_a@
identifier rw.store,rwf.rwfunc2_store;
@@
- store
+ rwfunc2_store

@@
identifier rw.x,rwf.rwfunc,rwf.rwfunc2_show,rwf.rwfunc2_store;
expression list es;
@@

(
- SENSOR_DEVICE_ATTR
+ SENSOR_DEVICE_ATTR_RW
|
- SENSOR_DEVICE_ATTR_2
+ SENSOR_DEVICE_ATTR_2_RW
)
  (x,
-  \(0644\|S_IRUGO|S_IWUSR\), rwfunc2_show, rwfunc2_store,es);
+  rwfunc,es);


------------------------------------------------------------------------

diff -u -p a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -30,9 +30,9 @@ int loongson3_cpu_temp(int cpu)

 static struct device *cpu_hwmon_dev;

-static ssize_t get_hwmon_name(struct device *dev,
-			struct device_attribute *attr, char *buf);
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, get_hwmon_name, NULL, 0);
+static ssize_t hwmon_name_show(struct device *dev,
+			       struct device_attribute *attr, char *buf);
+static SENSOR_DEVICE_ATTR_RO(name, hwmon_name, 0);

 static struct attribute *cpu_hwmon_attributes[] = {
 	&sensor_dev_attr_name.dev_attr.attr,
@@ -45,25 +45,25 @@ static struct attribute_group cpu_hwmon_
 };

 /* Hwmon device get name */
-static ssize_t get_hwmon_name(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t hwmon_name_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "cpu-hwmon\n");
 }

-static ssize_t get_cpu0_temp(struct device *dev,
-			struct device_attribute *attr, char *buf);
-static ssize_t get_cpu1_temp(struct device *dev,
-			struct device_attribute *attr, char *buf);
-static ssize_t cpu0_temp_label(struct device *dev,
-			struct device_attribute *attr, char *buf);
-static ssize_t cpu1_temp_label(struct device *dev,
-			struct device_attribute *attr, char *buf);
-
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, get_cpu0_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, cpu0_temp_label, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, get_cpu1_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, cpu1_temp_label, NULL, 2);
+static ssize_t cpu0_temp_show(struct device *dev,
+			      struct device_attribute *attr, char *buf);
+static ssize_t cpu1_temp_show(struct device *dev,
+			      struct device_attribute *attr, char *buf);
+static ssize_t cpu0_temp_label_show(struct device *dev,
+				    struct device_attribute *attr, char *buf);
+static ssize_t cpu1_temp_label_show(struct device *dev,
+				    struct device_attribute *attr, char *buf);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, cpu0_temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_label, cpu0_temp_label, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, cpu1_temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp2_label, cpu1_temp_label, 2);

 static const struct attribute *hwmon_cputemp1[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
@@ -77,27 +77,27 @@ static const struct attribute *hwmon_cpu
 	NULL
 };

-static ssize_t cpu0_temp_label(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t cpu0_temp_label_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "CPU 0 Temperature\n");
 }

-static ssize_t cpu1_temp_label(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t cpu1_temp_label_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "CPU 1 Temperature\n");
 }

-static ssize_t get_cpu0_temp(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t cpu0_temp_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	int value = loongson3_cpu_temp(0);
 	return sprintf(buf, "%d\n", value);
 }

-static ssize_t get_cpu1_temp(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t cpu1_temp_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	int value = loongson3_cpu_temp(1);
 	return sprintf(buf, "%d\n", value);
diff -u -p a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -39,7 +39,7 @@

 #if defined(CONFIG_HWMON) || (defined(MODULE) && defined(CONFIG_HWMON_MODULE))
 static ssize_t
-nouveau_hwmon_show_temp(struct device *d, struct device_attribute *a, char *buf)
+nouveau_hwmon_temp_show(struct device *d, struct device_attribute *a, char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -51,21 +51,21 @@ nouveau_hwmon_show_temp(struct device *d

 	return snprintf(buf, PAGE_SIZE, "%d\n", temp * 1000);
 }
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, nouveau_hwmon_show_temp,
-						  NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, nouveau_hwmon_temp, 0);

 static ssize_t
-nouveau_hwmon_show_temp1_auto_point1_pwm(struct device *d,
+nouveau_hwmon_temp1_auto_point1_pwm_show(struct device *d,
 					 struct device_attribute *a, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%d\n", 100);
 }
-static SENSOR_DEVICE_ATTR(temp1_auto_point1_pwm, S_IRUGO,
-			  nouveau_hwmon_show_temp1_auto_point1_pwm, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_auto_point1_pwm,
+			     nouveau_hwmon_temp1_auto_point1_pwm, 0);

 static ssize_t
-nouveau_hwmon_temp1_auto_point1_temp(struct device *d,
-				     struct device_attribute *a, char *buf)
+nouveau_hwmon_temp1_auto_point1_temp_show(struct device *d,
+					  struct device_attribute *a,
+					  char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -75,9 +75,9 @@ nouveau_hwmon_temp1_auto_point1_temp(str
 	      therm->attr_get(therm, NVKM_THERM_ATTR_THRS_FAN_BOOST) * 1000);
 }
 static ssize_t
-nouveau_hwmon_set_temp1_auto_point1_temp(struct device *d,
-					 struct device_attribute *a,
-					 const char *buf, size_t count)
+nouveau_hwmon_temp1_auto_point1_temp_store(struct device *d,
+					   struct device_attribute *a,
+					   const char *buf, size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -92,13 +92,13 @@ nouveau_hwmon_set_temp1_auto_point1_temp

 	return count;
 }
-static SENSOR_DEVICE_ATTR(temp1_auto_point1_temp, S_IRUGO | S_IWUSR,
-			  nouveau_hwmon_temp1_auto_point1_temp,
-			  nouveau_hwmon_set_temp1_auto_point1_temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_point1_temp,
+			     nouveau_hwmon_temp1_auto_point1_temp, 0);

 static ssize_t
-nouveau_hwmon_temp1_auto_point1_temp_hyst(struct device *d,
-					  struct device_attribute *a, char *buf)
+nouveau_hwmon_temp1_auto_point1_temp_hyst_show(struct device *d,
+					       struct device_attribute *a,
+					       char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -108,9 +108,9 @@ nouveau_hwmon_temp1_auto_point1_temp_hys
 	 therm->attr_get(therm, NVKM_THERM_ATTR_THRS_FAN_BOOST_HYST) * 1000);
 }
 static ssize_t
-nouveau_hwmon_set_temp1_auto_point1_temp_hyst(struct device *d,
-					      struct device_attribute *a,
-					      const char *buf, size_t count)
+nouveau_hwmon_temp1_auto_point1_temp_hyst_store(struct device *d,
+						struct device_attribute *a,
+						const char *buf, size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -125,12 +125,12 @@ nouveau_hwmon_set_temp1_auto_point1_temp

 	return count;
 }
-static SENSOR_DEVICE_ATTR(temp1_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
-			  nouveau_hwmon_temp1_auto_point1_temp_hyst,
-			  nouveau_hwmon_set_temp1_auto_point1_temp_hyst, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_point1_temp_hyst,
+			     nouveau_hwmon_temp1_auto_point1_temp_hyst, 0);

 static ssize_t
-nouveau_hwmon_max_temp(struct device *d, struct device_attribute *a, char *buf)
+nouveau_hwmon_max_temp_show(struct device *d, struct device_attribute *a,
+			    char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -140,8 +140,8 @@ nouveau_hwmon_max_temp(struct device *d,
 	       therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK) * 1000);
 }
 static ssize_t
-nouveau_hwmon_set_max_temp(struct device *d, struct device_attribute *a,
-						const char *buf, size_t count)
+nouveau_hwmon_max_temp_store(struct device *d, struct device_attribute *a,
+			     const char *buf, size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -155,13 +155,11 @@ nouveau_hwmon_set_max_temp(struct device

 	return count;
 }
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR, nouveau_hwmon_max_temp,
-						  nouveau_hwmon_set_max_temp,
-						  0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, nouveau_hwmon_max_temp, 0);

 static ssize_t
-nouveau_hwmon_max_temp_hyst(struct device *d, struct device_attribute *a,
-			    char *buf)
+nouveau_hwmon_max_temp_hyst_show(struct device *d, struct device_attribute *a,
+				 char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -171,8 +169,9 @@ nouveau_hwmon_max_temp_hyst(struct devic
 	  therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK_HYST) * 1000);
 }
 static ssize_t
-nouveau_hwmon_set_max_temp_hyst(struct device *d, struct device_attribute *a,
-						const char *buf, size_t count)
+nouveau_hwmon_max_temp_hyst_store(struct device *d,
+				  struct device_attribute *a, const char *buf,
+				  size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -187,13 +186,11 @@ nouveau_hwmon_set_max_temp_hyst(struct d

 	return count;
 }
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR,
-			  nouveau_hwmon_max_temp_hyst,
-			  nouveau_hwmon_set_max_temp_hyst, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, nouveau_hwmon_max_temp_hyst, 0);

 static ssize_t
-nouveau_hwmon_critical_temp(struct device *d, struct device_attribute *a,
-							char *buf)
+nouveau_hwmon_critical_temp_show(struct device *d, struct device_attribute *a,
+				 char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -203,9 +200,9 @@ nouveau_hwmon_critical_temp(struct devic
 	       therm->attr_get(therm, NVKM_THERM_ATTR_THRS_CRITICAL) * 1000);
 }
 static ssize_t
-nouveau_hwmon_set_critical_temp(struct device *d, struct device_attribute *a,
-							    const char *buf,
-								size_t count)
+nouveau_hwmon_critical_temp_store(struct device *d,
+				  struct device_attribute *a, const char *buf,
+				  size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -219,14 +216,11 @@ nouveau_hwmon_set_critical_temp(struct d

 	return count;
 }
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO | S_IWUSR,
-						nouveau_hwmon_critical_temp,
-						nouveau_hwmon_set_critical_temp,
-						0);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit, nouveau_hwmon_critical_temp, 0);

 static ssize_t
-nouveau_hwmon_critical_temp_hyst(struct device *d, struct device_attribute *a,
-							char *buf)
+nouveau_hwmon_critical_temp_hyst_show(struct device *d,
+				      struct device_attribute *a, char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -236,10 +230,9 @@ nouveau_hwmon_critical_temp_hyst(struct
 	  therm->attr_get(therm, NVKM_THERM_ATTR_THRS_CRITICAL_HYST) * 1000);
 }
 static ssize_t
-nouveau_hwmon_set_critical_temp_hyst(struct device *d,
-				     struct device_attribute *a,
-				     const char *buf,
-				     size_t count)
+nouveau_hwmon_critical_temp_hyst_store(struct device *d,
+				       struct device_attribute *a,
+				       const char *buf, size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -254,12 +247,11 @@ nouveau_hwmon_set_critical_temp_hyst(str

 	return count;
 }
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO | S_IWUSR,
-			  nouveau_hwmon_critical_temp_hyst,
-			  nouveau_hwmon_set_critical_temp_hyst, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit_hyst,
+			     nouveau_hwmon_critical_temp_hyst, 0);
 static ssize_t
-nouveau_hwmon_emergency_temp(struct device *d, struct device_attribute *a,
-							char *buf)
+nouveau_hwmon_emergency_temp_show(struct device *d,
+				  struct device_attribute *a, char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -269,9 +261,9 @@ nouveau_hwmon_emergency_temp(struct devi
 	       therm->attr_get(therm, NVKM_THERM_ATTR_THRS_SHUTDOWN) * 1000);
 }
 static ssize_t
-nouveau_hwmon_set_emergency_temp(struct device *d, struct device_attribute *a,
-							    const char *buf,
-								size_t count)
+nouveau_hwmon_emergency_temp_store(struct device *d,
+				   struct device_attribute *a,
+				   const char *buf, size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -285,14 +277,11 @@ nouveau_hwmon_set_emergency_temp(struct

 	return count;
 }
-static SENSOR_DEVICE_ATTR(temp1_emergency, S_IRUGO | S_IWUSR,
-					nouveau_hwmon_emergency_temp,
-					nouveau_hwmon_set_emergency_temp,
-					0);
+static SENSOR_DEVICE_ATTR_RW(temp1_emergency, nouveau_hwmon_emergency_temp, 0);

 static ssize_t
-nouveau_hwmon_emergency_temp_hyst(struct device *d, struct device_attribute *a,
-							char *buf)
+nouveau_hwmon_emergency_temp_hyst_show(struct device *d,
+				       struct device_attribute *a, char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -302,10 +291,9 @@ nouveau_hwmon_emergency_temp_hyst(struct
 	  therm->attr_get(therm, NVKM_THERM_ATTR_THRS_SHUTDOWN_HYST) * 1000);
 }
 static ssize_t
-nouveau_hwmon_set_emergency_temp_hyst(struct device *d,
-				      struct device_attribute *a,
-				      const char *buf,
-				      size_t count)
+nouveau_hwmon_emergency_temp_hyst_store(struct device *d,
+					struct device_attribute *a,
+					const char *buf, size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -320,31 +308,27 @@ nouveau_hwmon_set_emergency_temp_hyst(st

 	return count;
 }
-static SENSOR_DEVICE_ATTR(temp1_emergency_hyst, S_IRUGO | S_IWUSR,
-					nouveau_hwmon_emergency_temp_hyst,
-					nouveau_hwmon_set_emergency_temp_hyst,
-					0);
+static SENSOR_DEVICE_ATTR_RW(temp1_emergency_hyst,
+			     nouveau_hwmon_emergency_temp_hyst, 0);

-static ssize_t nouveau_hwmon_show_name(struct device *dev,
+static ssize_t nouveau_hwmon_name_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
 	return sprintf(buf, "nouveau\n");
 }
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, nouveau_hwmon_show_name, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(name, nouveau_hwmon_name, 0);

-static ssize_t nouveau_hwmon_show_update_rate(struct device *dev,
+static ssize_t nouveau_hwmon_update_rate_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
 	return sprintf(buf, "1000\n");
 }
-static SENSOR_DEVICE_ATTR(update_rate, S_IRUGO,
-						nouveau_hwmon_show_update_rate,
-						NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(update_rate, nouveau_hwmon_update_rate, 0);

 static ssize_t
-nouveau_hwmon_show_fan1_input(struct device *d, struct device_attribute *attr,
+nouveau_hwmon_fan1_input_show(struct device *d, struct device_attribute *attr,
 			      char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
@@ -353,12 +337,11 @@ nouveau_hwmon_show_fan1_input(struct dev

 	return snprintf(buf, PAGE_SIZE, "%d\n", nvkm_therm_fan_sense(therm));
 }
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, nouveau_hwmon_show_fan1_input,
-			  NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, nouveau_hwmon_fan1_input, 0);

  static ssize_t
-nouveau_hwmon_get_pwm1_enable(struct device *d,
-			   struct device_attribute *a, char *buf)
+nouveau_hwmon_pwm1_enable_show(struct device *d, struct device_attribute *a,
+			       char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -373,8 +356,8 @@ nouveau_hwmon_get_pwm1_enable(struct dev
 }

 static ssize_t
-nouveau_hwmon_set_pwm1_enable(struct device *d, struct device_attribute *a,
-			   const char *buf, size_t count)
+nouveau_hwmon_pwm1_enable_store(struct device *d, struct device_attribute *a,
+				const char *buf, size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -392,12 +375,11 @@ nouveau_hwmon_set_pwm1_enable(struct dev
 	else
 		return count;
 }
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
-			  nouveau_hwmon_get_pwm1_enable,
-			  nouveau_hwmon_set_pwm1_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, nouveau_hwmon_pwm1_enable, 0);

 static ssize_t
-nouveau_hwmon_get_pwm1(struct device *d, struct device_attribute *a, char *buf)
+nouveau_hwmon_pwm1_show(struct device *d, struct device_attribute *a,
+			char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -412,8 +394,8 @@ nouveau_hwmon_get_pwm1(struct device *d,
 }

 static ssize_t
-nouveau_hwmon_set_pwm1(struct device *d, struct device_attribute *a,
-		       const char *buf, size_t count)
+nouveau_hwmon_pwm1_store(struct device *d, struct device_attribute *a,
+			 const char *buf, size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -431,13 +413,11 @@ nouveau_hwmon_set_pwm1(struct device *d,
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR,
-			  nouveau_hwmon_get_pwm1,
-			  nouveau_hwmon_set_pwm1, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1, nouveau_hwmon_pwm1, 0);

 static ssize_t
-nouveau_hwmon_get_pwm1_min(struct device *d,
-			   struct device_attribute *a, char *buf)
+nouveau_hwmon_pwm1_min_show(struct device *d, struct device_attribute *a,
+			    char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -452,8 +432,8 @@ nouveau_hwmon_get_pwm1_min(struct device
 }

 static ssize_t
-nouveau_hwmon_set_pwm1_min(struct device *d, struct device_attribute *a,
-			   const char *buf, size_t count)
+nouveau_hwmon_pwm1_min_store(struct device *d, struct device_attribute *a,
+			     const char *buf, size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -471,13 +451,11 @@ nouveau_hwmon_set_pwm1_min(struct device
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1_min, S_IRUGO | S_IWUSR,
-			  nouveau_hwmon_get_pwm1_min,
-			  nouveau_hwmon_set_pwm1_min, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_min, nouveau_hwmon_pwm1_min, 0);

 static ssize_t
-nouveau_hwmon_get_pwm1_max(struct device *d,
-			   struct device_attribute *a, char *buf)
+nouveau_hwmon_pwm1_max_show(struct device *d, struct device_attribute *a,
+			    char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -492,8 +470,8 @@ nouveau_hwmon_get_pwm1_max(struct device
 }

 static ssize_t
-nouveau_hwmon_set_pwm1_max(struct device *d, struct device_attribute *a,
-			   const char *buf, size_t count)
+nouveau_hwmon_pwm1_max_store(struct device *d, struct device_attribute *a,
+			     const char *buf, size_t count)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -511,13 +489,11 @@ nouveau_hwmon_set_pwm1_max(struct device
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1_max, S_IRUGO | S_IWUSR,
-			  nouveau_hwmon_get_pwm1_max,
-			  nouveau_hwmon_set_pwm1_max, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_max, nouveau_hwmon_pwm1_max, 0);

 static ssize_t
-nouveau_hwmon_get_in0_input(struct device *d,
-			    struct device_attribute *a, char *buf)
+nouveau_hwmon_in0_input_show(struct device *d, struct device_attribute *a,
+			     char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -531,12 +507,11 @@ nouveau_hwmon_get_in0_input(struct devic
 	return sprintf(buf, "%i\n", ret / 1000);
 }

-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO,
-			  nouveau_hwmon_get_in0_input, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(in0_input, nouveau_hwmon_in0_input, 0);

 static ssize_t
-nouveau_hwmon_get_in0_min(struct device *d,
-			    struct device_attribute *a, char *buf)
+nouveau_hwmon_in0_min_show(struct device *d, struct device_attribute *a,
+			   char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -548,12 +523,11 @@ nouveau_hwmon_get_in0_min(struct device
 	return sprintf(buf, "%i\n", volt->min_uv / 1000);
 }

-static SENSOR_DEVICE_ATTR(in0_min, S_IRUGO,
-			  nouveau_hwmon_get_in0_min, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(in0_min, nouveau_hwmon_in0_min, 0);

 static ssize_t
-nouveau_hwmon_get_in0_max(struct device *d,
-			    struct device_attribute *a, char *buf)
+nouveau_hwmon_in0_max_show(struct device *d, struct device_attribute *a,
+			   char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -565,22 +539,20 @@ nouveau_hwmon_get_in0_max(struct device
 	return sprintf(buf, "%i\n", volt->max_uv / 1000);
 }

-static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO,
-			  nouveau_hwmon_get_in0_max, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(in0_max, nouveau_hwmon_in0_max, 0);

 static ssize_t
-nouveau_hwmon_get_in0_label(struct device *d,
-			    struct device_attribute *a, char *buf)
+nouveau_hwmon_in0_label_show(struct device *d, struct device_attribute *a,
+			     char *buf)
 {
 	return sprintf(buf, "GPU core\n");
 }

-static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO,
-			  nouveau_hwmon_get_in0_label, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(in0_label, nouveau_hwmon_in0_label, 0);

 static ssize_t
-nouveau_hwmon_get_power1_input(struct device *d, struct device_attribute *a,
-			       char *buf)
+nouveau_hwmon_power1_input_show(struct device *d, struct device_attribute *a,
+				char *buf)
 {
 	struct drm_device *dev = dev_get_drvdata(d);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -593,8 +565,7 @@ nouveau_hwmon_get_power1_input(struct de
 	return sprintf(buf, "%i\n", result);
 }

-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO,
-			  nouveau_hwmon_get_power1_input, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(power1_input, nouveau_hwmon_power1_input, 0);

 static struct attribute *hwmon_default_attributes[] = {
 	&sensor_dev_attr_name.dev_attr.attr,
diff -u -p a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -604,7 +604,7 @@ static DEVICE_ATTR(pp_mclk_od, S_IRUGO |
 		amdgpu_get_pp_mclk_od,
 		amdgpu_set_pp_mclk_od);

-static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
+static ssize_t amdgpu_hwmon_temp_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
@@ -625,7 +625,7 @@ static ssize_t amdgpu_hwmon_show_temp(st
 	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
 }

-static ssize_t amdgpu_hwmon_show_temp_thresh(struct device *dev,
+static ssize_t amdgpu_hwmon_temp_thresh_show(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
@@ -641,9 +641,9 @@ static ssize_t amdgpu_hwmon_show_temp_th
 	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
 }

-static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
-					    struct device_attribute *attr,
-					    char *buf)
+static ssize_t amdgpu_hwmon_pwm1_enable_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	u32 pwm_mode = 0;
@@ -657,10 +657,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_ena
 	return sprintf(buf, "%i\n", pwm_mode == FDO_PWM_MODE_STATIC ? 1 : 2);
 }

-static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf,
-					    size_t count)
+static ssize_t amdgpu_hwmon_pwm1_enable_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	int err;
@@ -685,23 +684,23 @@ static ssize_t amdgpu_hwmon_set_pwm1_ena
 	return count;
 }

-static ssize_t amdgpu_hwmon_get_pwm1_min(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
+static ssize_t amdgpu_hwmon_pwm1_min_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	return sprintf(buf, "%i\n", 0);
 }

-static ssize_t amdgpu_hwmon_get_pwm1_max(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
+static ssize_t amdgpu_hwmon_pwm1_max_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	return sprintf(buf, "%i\n", 255);
 }

-static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
+static ssize_t amdgpu_hwmon_pwm1_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	int err;
@@ -720,9 +719,9 @@ static ssize_t amdgpu_hwmon_set_pwm1(str
 	return count;
 }

-static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
+static ssize_t amdgpu_hwmon_pwm1_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	int err;
@@ -737,9 +736,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(str
 	return sprintf(buf, "%i\n", speed);
 }

-static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t amdgpu_hwmon_fan1_input_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	int err;
@@ -752,14 +751,14 @@ static ssize_t amdgpu_hwmon_get_fan1_inp
 	return sprintf(buf, "%i\n", speed);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, amdgpu_hwmon_show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, amdgpu_hwmon_show_temp_thresh, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, amdgpu_hwmon_show_temp_thresh, NULL, 1);
-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, amdgpu_hwmon_get_pwm1, amdgpu_hwmon_set_pwm1, 0);
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, amdgpu_hwmon_get_pwm1_enable, amdgpu_hwmon_set_pwm1_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm1_min, S_IRUGO, amdgpu_hwmon_get_pwm1_min, NULL, 0);
-static SENSOR_DEVICE_ATTR(pwm1_max, S_IRUGO, amdgpu_hwmon_get_pwm1_max, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, amdgpu_hwmon_get_fan1_input, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, amdgpu_hwmon_temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit, amdgpu_hwmon_temp_thresh, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_hyst, amdgpu_hwmon_temp_thresh, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1, amdgpu_hwmon_pwm1, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, amdgpu_hwmon_pwm1_enable, 0);
+static SENSOR_DEVICE_ATTR_RO(pwm1_min, amdgpu_hwmon_pwm1_min, 0);
+static SENSOR_DEVICE_ATTR_RO(pwm1_max, amdgpu_hwmon_pwm1_max, 0);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, amdgpu_hwmon_fan1_input, 0);

 static struct attribute *hwmon_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/gpu/drm/radeon/radeon_pm.c b/drivers/gpu/drm/radeon/radeon_pm.c
--- a/drivers/gpu/drm/radeon/radeon_pm.c
+++ b/drivers/gpu/drm/radeon/radeon_pm.c
@@ -564,9 +564,9 @@ fail:
 	return count;
 }

-static ssize_t radeon_hwmon_get_pwm1_enable(struct device *dev,
-					    struct device_attribute *attr,
-					    char *buf)
+static ssize_t radeon_hwmon_pwm1_enable_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
 {
 	struct radeon_device *rdev = dev_get_drvdata(dev);
 	u32 pwm_mode = 0;
@@ -578,10 +578,9 @@ static ssize_t radeon_hwmon_get_pwm1_ena
 	return sprintf(buf, "%i\n", pwm_mode == FDO_PWM_MODE_STATIC ? 1 : 2);
 }

-static ssize_t radeon_hwmon_set_pwm1_enable(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf,
-					    size_t count)
+static ssize_t radeon_hwmon_pwm1_enable_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
 {
 	struct radeon_device *rdev = dev_get_drvdata(dev);
 	int err;
@@ -606,23 +605,23 @@ static ssize_t radeon_hwmon_set_pwm1_ena
 	return count;
 }

-static ssize_t radeon_hwmon_get_pwm1_min(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
+static ssize_t radeon_hwmon_pwm1_min_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	return sprintf(buf, "%i\n", 0);
 }

-static ssize_t radeon_hwmon_get_pwm1_max(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
+static ssize_t radeon_hwmon_pwm1_max_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	return sprintf(buf, "%i\n", 255);
 }

-static ssize_t radeon_hwmon_set_pwm1(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
+static ssize_t radeon_hwmon_pwm1_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
 {
 	struct radeon_device *rdev = dev_get_drvdata(dev);
 	int err;
@@ -641,9 +640,9 @@ static ssize_t radeon_hwmon_set_pwm1(str
 	return count;
 }

-static ssize_t radeon_hwmon_get_pwm1(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
+static ssize_t radeon_hwmon_pwm1_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
 {
 	struct radeon_device *rdev = dev_get_drvdata(dev);
 	int err;
@@ -665,7 +664,7 @@ static DEVICE_ATTR(power_dpm_force_perfo
 		   radeon_get_dpm_forced_performance_level,
 		   radeon_set_dpm_forced_performance_level);

-static ssize_t radeon_hwmon_show_temp(struct device *dev,
+static ssize_t radeon_hwmon_temp_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
@@ -686,7 +685,7 @@ static ssize_t radeon_hwmon_show_temp(st
 	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
 }

-static ssize_t radeon_hwmon_show_temp_thresh(struct device *dev,
+static ssize_t radeon_hwmon_temp_thresh_show(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
@@ -702,13 +701,13 @@ static ssize_t radeon_hwmon_show_temp_th
 	return snprintf(buf, PAGE_SIZE, "%d\n", temp);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, radeon_hwmon_show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, radeon_hwmon_show_temp_thresh, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, radeon_hwmon_show_temp_thresh, NULL, 1);
-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, radeon_hwmon_get_pwm1, radeon_hwmon_set_pwm1, 0);
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, radeon_hwmon_get_pwm1_enable, radeon_hwmon_set_pwm1_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm1_min, S_IRUGO, radeon_hwmon_get_pwm1_min, NULL, 0);
-static SENSOR_DEVICE_ATTR(pwm1_max, S_IRUGO, radeon_hwmon_get_pwm1_max, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, radeon_hwmon_temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit, radeon_hwmon_temp_thresh, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_hyst, radeon_hwmon_temp_thresh, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1, radeon_hwmon_pwm1, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, radeon_hwmon_pwm1_enable, 0);
+static SENSOR_DEVICE_ATTR_RO(pwm1_min, radeon_hwmon_pwm1_min, 0);
+static SENSOR_DEVICE_ATTR_RO(pwm1_max, radeon_hwmon_pwm1_max, 0);


 static struct attribute *hwmon_attributes[] = {
diff -u -p a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -81,8 +81,8 @@ static void pwm_fan_update_state(struct
 	ctx->pwm_fan_state = i;
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
 	unsigned long pwm;
@@ -99,7 +99,7 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }

-static ssize_t show_pwm(struct device *dev,
+static ssize_t pwm_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
@@ -108,7 +108,7 @@ static ssize_t show_pwm(struct device *d
 }


-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);

 static struct attribute *pwm_fan_attrs[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
diff -u -p a/drivers/hwmon/i5500_temp.c b/drivers/hwmon/i5500_temp.c
--- a/drivers/hwmon/i5500_temp.c
+++ b/drivers/hwmon/i5500_temp.c
@@ -58,7 +58,7 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%ld\n", temp);
 }

-static ssize_t show_thresh(struct device *dev,
+static ssize_t thresh_show(struct device *dev,
 			   struct device_attribute *devattr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->parent);
@@ -72,7 +72,7 @@ static ssize_t show_thresh(struct device
 	return sprintf(buf, "%ld\n", temp);
 }

-static ssize_t show_alarm(struct device *dev,
+static ssize_t alarm_show(struct device *dev,
 			  struct device_attribute *devattr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->parent);
@@ -84,11 +84,11 @@ static ssize_t show_alarm(struct device
 }

 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_thresh, NULL, 0xE2);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_thresh, NULL, 0xEC);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_thresh, NULL, 0xEE);
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit, thresh, 0xE2);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_hyst, thresh, 0xEC);
+static SENSOR_DEVICE_ATTR_RO(temp1_max, thresh, 0xEE);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 1);

 static struct attribute *i5500_temp_attrs[] = {
 	&dev_attr_temp1_input.attr,
diff -u -p a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -605,7 +605,7 @@ static inline void __exit i8k_exit_procf
  * Hwmon interface
  */

-static ssize_t i8k_hwmon_show_temp_label(struct device *dev,
+static ssize_t i8k_hwmon_temp_label_show(struct device *dev,
 					 struct device_attribute *devattr,
 					 char *buf)
 {
@@ -628,7 +628,7 @@ static ssize_t i8k_hwmon_show_temp_label
 	return sprintf(buf, "%s\n", labels[type]);
 }

-static ssize_t i8k_hwmon_show_temp(struct device *dev,
+static ssize_t i8k_hwmon_temp_show(struct device *dev,
 				   struct device_attribute *devattr,
 				   char *buf)
 {
@@ -641,7 +641,7 @@ static ssize_t i8k_hwmon_show_temp(struc
 	return sprintf(buf, "%d\n", temp * 1000);
 }

-static ssize_t i8k_hwmon_show_fan_label(struct device *dev,
+static ssize_t i8k_hwmon_fan_label_show(struct device *dev,
 					struct device_attribute *devattr,
 					char *buf)
 {
@@ -672,7 +672,7 @@ static ssize_t i8k_hwmon_show_fan_label(
 	return sprintf(buf, "%s%s\n", (dock ? "Docking " : ""), labels[type]);
 }

-static ssize_t i8k_hwmon_show_fan(struct device *dev,
+static ssize_t i8k_hwmon_fan_show(struct device *dev,
 				  struct device_attribute *devattr,
 				  char *buf)
 {
@@ -685,7 +685,7 @@ static ssize_t i8k_hwmon_show_fan(struct
 	return sprintf(buf, "%d\n", fan_speed);
 }

-static ssize_t i8k_hwmon_show_pwm(struct device *dev,
+static ssize_t i8k_hwmon_pwm_show(struct device *dev,
 				  struct device_attribute *devattr,
 				  char *buf)
 {
@@ -698,9 +698,9 @@ static ssize_t i8k_hwmon_show_pwm(struct
 	return sprintf(buf, "%d\n", clamp_val(status * i8k_pwm_mult, 0, 255));
 }

-static ssize_t i8k_hwmon_set_pwm(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t count)
+static ssize_t i8k_hwmon_pwm_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(attr)->index;
 	unsigned long val;
@@ -718,35 +718,23 @@ static ssize_t i8k_hwmon_set_pwm(struct
 	return err < 0 ? -EIO : count;
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, i8k_hwmon_show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, i8k_hwmon_show_temp_label, NULL,
-			  0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, i8k_hwmon_show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, i8k_hwmon_show_temp_label, NULL,
-			  1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, i8k_hwmon_show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, i8k_hwmon_show_temp_label, NULL,
-			  2);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, i8k_hwmon_show_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp4_label, S_IRUGO, i8k_hwmon_show_temp_label, NULL,
-			  3);
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, i8k_hwmon_show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan1_label, S_IRUGO, i8k_hwmon_show_fan_label, NULL,
-			  0);
-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, i8k_hwmon_show_pwm,
-			  i8k_hwmon_set_pwm, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, i8k_hwmon_show_fan, NULL,
-			  1);
-static SENSOR_DEVICE_ATTR(fan2_label, S_IRUGO, i8k_hwmon_show_fan_label, NULL,
-			  1);
-static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, i8k_hwmon_show_pwm,
-			  i8k_hwmon_set_pwm, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, i8k_hwmon_show_fan, NULL,
-			  2);
-static SENSOR_DEVICE_ATTR(fan3_label, S_IRUGO, i8k_hwmon_show_fan_label, NULL,
-			  2);
-static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, i8k_hwmon_show_pwm,
-			  i8k_hwmon_set_pwm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, i8k_hwmon_temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_label, i8k_hwmon_temp_label, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, i8k_hwmon_temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_label, i8k_hwmon_temp_label, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, i8k_hwmon_temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_label, i8k_hwmon_temp_label, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, i8k_hwmon_temp, 3);
+static SENSOR_DEVICE_ATTR_RO(temp4_label, i8k_hwmon_temp_label, 3);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, i8k_hwmon_fan, 0);
+static SENSOR_DEVICE_ATTR_RO(fan1_label, i8k_hwmon_fan_label, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1, i8k_hwmon_pwm, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, i8k_hwmon_fan, 1);
+static SENSOR_DEVICE_ATTR_RO(fan2_label, i8k_hwmon_fan_label, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm2, i8k_hwmon_pwm, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, i8k_hwmon_fan, 2);
+static SENSOR_DEVICE_ATTR_RO(fan3_label, i8k_hwmon_fan_label, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm3, i8k_hwmon_pwm, 2);

 static struct attribute *i8k_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,	/* 0 */
diff -u -p a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
--- a/drivers/hwmon/max6642.c
+++ b/drivers/hwmon/max6642.c
@@ -206,7 +206,7 @@ static struct max6642_data *max6642_upda
  * Sysfs stuff
  */

-static ssize_t show_temp_max10(struct device *dev,
+static ssize_t temp_max10_show(struct device *dev,
 			       struct device_attribute *dev_attr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
@@ -216,7 +216,7 @@ static ssize_t show_temp_max10(struct de
 		       temp_from_reg10(data->temp_input[attr->index]));
 }

-static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_max_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(attr);
@@ -225,8 +225,9 @@ static ssize_t show_temp_max(struct devi
 	return sprintf(buf, "%d\n", temp_from_reg(data->temp_high[attr2->nr]));
 }

-static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t temp_max_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
 {
 	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(attr);
 	struct max6642_data *data = dev_get_drvdata(dev);
@@ -245,7 +246,7 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
@@ -253,15 +254,15 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_max10, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_max10, NULL, 1);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
-			    set_temp_max, 0, MAX6642_REG_W_LOCAL_HIGH);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
-			    set_temp_max, 1, MAX6642_REG_W_REMOTE_HIGH);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_max10, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_max10, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp_max, 0,
+			       MAX6642_REG_W_LOCAL_HIGH);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp_max, 1,
+			       MAX6642_REG_W_REMOTE_HIGH);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 4);

 static struct attribute *max6642_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
--- a/drivers/hwmon/da9052-hwmon.c
+++ b/drivers/hwmon/da9052-hwmon.c
@@ -72,8 +72,9 @@ static inline int da9052_disable_vddout_
 				 DA9052_ADCCONT_AUTOVDDEN, 0);
 }

-static ssize_t da9052_read_vddout(struct device *dev,
-				  struct device_attribute *devattr, char *buf)
+static ssize_t da9052_read_vddout_show(struct device *dev,
+				       struct device_attribute *devattr,
+				       char *buf)
 {
 	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
 	int ret, vdd;
@@ -104,8 +105,9 @@ hwmon_err:
 	return ret;
 }

-static ssize_t da9052_read_ich(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
+static ssize_t da9052_read_ich_show(struct device *dev,
+				    struct device_attribute *devattr,
+				    char *buf)
 {
 	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
 	int ret;
@@ -118,16 +120,18 @@ static ssize_t da9052_read_ich(struct de
 	return sprintf(buf, "%d\n", DIV_ROUND_CLOSEST(ret * 39, 10));
 }

-static ssize_t da9052_read_tbat(struct device *dev,
-				struct device_attribute *devattr, char *buf)
+static ssize_t da9052_read_tbat_show(struct device *dev,
+				     struct device_attribute *devattr,
+				     char *buf)
 {
 	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);

 	return sprintf(buf, "%d\n", da9052_adc_read_temp(hwmon->da9052));
 }

-static ssize_t da9052_read_vbat(struct device *dev,
-				struct device_attribute *devattr, char *buf)
+static ssize_t da9052_read_vbat_show(struct device *dev,
+				     struct device_attribute *devattr,
+				     char *buf)
 {
 	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
 	int ret;
@@ -139,9 +143,9 @@ static ssize_t da9052_read_vbat(struct d
 	return sprintf(buf, "%d\n", volt_reg_to_mv(ret));
 }

-static ssize_t da9052_read_misc_channel(struct device *dev,
-					struct device_attribute *devattr,
-					char *buf)
+static ssize_t da9052_read_misc_channel_show(struct device *dev,
+					     struct device_attribute *devattr,
+					     char *buf)
 {
 	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
 	int channel = to_sensor_dev_attr(devattr)->index;
@@ -154,8 +158,9 @@ static ssize_t da9052_read_misc_channel(
 	return sprintf(buf, "%d\n", input_reg_to_mv(ret));
 }

-static ssize_t da9052_read_tjunc(struct device *dev,
-				 struct device_attribute *devattr, char *buf)
+static ssize_t da9052_read_tjunc_show(struct device *dev,
+				      struct device_attribute *devattr,
+				      char *buf)
 {
 	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
 	int tjunc;
@@ -176,8 +181,9 @@ static ssize_t da9052_read_tjunc(struct
 	return sprintf(buf, "%d\n", 1708 * (tjunc - toffset) - 108800);
 }

-static ssize_t da9052_read_vbbat(struct device *dev,
-				 struct device_attribute *devattr, char *buf)
+static ssize_t da9052_read_vbbat_show(struct device *dev,
+				      struct device_attribute *devattr,
+				      char *buf)
 {
 	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
 	int ret;
@@ -189,51 +195,36 @@ static ssize_t da9052_read_vbbat(struct
 	return sprintf(buf, "%d\n", vbbat_reg_to_mv(ret));
 }

-static ssize_t show_label(struct device *dev,
+static ssize_t label_show(struct device *dev,
 			  struct device_attribute *devattr, char *buf)
 {
 	return sprintf(buf, "%s\n",
 		       input_names[to_sensor_dev_attr(devattr)->index]);
 }

-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, da9052_read_vddout, NULL,
-			  DA9052_ADC_VDDOUT);
-static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, show_label, NULL,
-			  DA9052_ADC_VDDOUT);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, da9052_read_vbat, NULL,
-			  DA9052_ADC_VBAT);
-static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL,
-			  DA9052_ADC_VBAT);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, da9052_read_misc_channel, NULL,
-			  DA9052_ADC_IN4);
-static SENSOR_DEVICE_ATTR(in4_label, S_IRUGO, show_label, NULL,
-			  DA9052_ADC_IN4);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, da9052_read_misc_channel, NULL,
-			  DA9052_ADC_IN5);
-static SENSOR_DEVICE_ATTR(in5_label, S_IRUGO, show_label, NULL,
-			  DA9052_ADC_IN5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, da9052_read_misc_channel, NULL,
-			  DA9052_ADC_IN6);
-static SENSOR_DEVICE_ATTR(in6_label, S_IRUGO, show_label, NULL,
-			  DA9052_ADC_IN6);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, da9052_read_vbbat, NULL,
-			  DA9052_ADC_VBBAT);
-static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, show_label, NULL,
-			  DA9052_ADC_VBBAT);
-
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, da9052_read_ich, NULL,
-			  DA9052_ADC_ICH);
-static SENSOR_DEVICE_ATTR(curr1_label, S_IRUGO, show_label, NULL,
-			  DA9052_ADC_ICH);
-
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, da9052_read_tbat, NULL,
-			  DA9052_ADC_TBAT);
-static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL,
-			  DA9052_ADC_TBAT);
-static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, da9052_read_tjunc, NULL,
-			  DA9052_ADC_TJUNC);
-static SENSOR_DEVICE_ATTR(temp8_label, S_IRUGO, show_label, NULL,
-			  DA9052_ADC_TJUNC);
+static SENSOR_DEVICE_ATTR_RO(in0_input, da9052_read_vddout, DA9052_ADC_VDDOUT);
+static SENSOR_DEVICE_ATTR_RO(in0_label, label, DA9052_ADC_VDDOUT);
+static SENSOR_DEVICE_ATTR_RO(in3_input, da9052_read_vbat, DA9052_ADC_VBAT);
+static SENSOR_DEVICE_ATTR_RO(in3_label, label, DA9052_ADC_VBAT);
+static SENSOR_DEVICE_ATTR_RO(in4_input, da9052_read_misc_channel,
+			     DA9052_ADC_IN4);
+static SENSOR_DEVICE_ATTR_RO(in4_label, label, DA9052_ADC_IN4);
+static SENSOR_DEVICE_ATTR_RO(in5_input, da9052_read_misc_channel,
+			     DA9052_ADC_IN5);
+static SENSOR_DEVICE_ATTR_RO(in5_label, label, DA9052_ADC_IN5);
+static SENSOR_DEVICE_ATTR_RO(in6_input, da9052_read_misc_channel,
+			     DA9052_ADC_IN6);
+static SENSOR_DEVICE_ATTR_RO(in6_label, label, DA9052_ADC_IN6);
+static SENSOR_DEVICE_ATTR_RO(in9_input, da9052_read_vbbat, DA9052_ADC_VBBAT);
+static SENSOR_DEVICE_ATTR_RO(in9_label, label, DA9052_ADC_VBBAT);
+
+static SENSOR_DEVICE_ATTR_RO(curr1_input, da9052_read_ich, DA9052_ADC_ICH);
+static SENSOR_DEVICE_ATTR_RO(curr1_label, label, DA9052_ADC_ICH);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_input, da9052_read_tbat, DA9052_ADC_TBAT);
+static SENSOR_DEVICE_ATTR_RO(temp2_label, label, DA9052_ADC_TBAT);
+static SENSOR_DEVICE_ATTR_RO(temp8_input, da9052_read_tjunc, DA9052_ADC_TJUNC);
+static SENSOR_DEVICE_ATTR_RO(temp8_label, label, DA9052_ADC_TJUNC);

 static struct attribute *da9052_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/vexpress-hwmon.c b/drivers/hwmon/vexpress-hwmon.c
--- a/drivers/hwmon/vexpress-hwmon.c
+++ b/drivers/hwmon/vexpress-hwmon.c
@@ -93,8 +93,7 @@ struct vexpress_hwmon_type {

 #if !defined(CONFIG_REGULATOR_VEXPRESS)
 static DEVICE_ATTR(in1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, vexpress_hwmon_u32_show,
-		NULL, 1000);
+static SENSOR_DEVICE_ATTR_RO(in1_input, vexpress_hwmon_u32, 1000);
 static struct attribute *vexpress_hwmon_attrs_volt[] = {
 	&dev_attr_in1_label.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
@@ -114,8 +113,7 @@ static struct vexpress_hwmon_type vexpre
 #endif

 static DEVICE_ATTR(curr1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, vexpress_hwmon_u32_show,
-		NULL, 1000);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, vexpress_hwmon_u32, 1000);
 static struct attribute *vexpress_hwmon_attrs_amp[] = {
 	&dev_attr_curr1_label.attr,
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
@@ -134,8 +132,7 @@ static struct vexpress_hwmon_type vexpre
 };

 static DEVICE_ATTR(temp1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, vexpress_hwmon_u32_show,
-		NULL, 1000);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, vexpress_hwmon_u32, 1000);
 static struct attribute *vexpress_hwmon_attrs_temp[] = {
 	&dev_attr_temp1_label.attr,
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
@@ -154,8 +151,7 @@ static struct vexpress_hwmon_type vexpre
 };

 static DEVICE_ATTR(power1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, vexpress_hwmon_u32_show,
-		NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(power1_input, vexpress_hwmon_u32, 1);
 static struct attribute *vexpress_hwmon_attrs_power[] = {
 	&dev_attr_power1_label.attr,
 	&sensor_dev_attr_power1_input.dev_attr.attr,
@@ -174,8 +170,7 @@ static struct vexpress_hwmon_type vexpre
 };

 static DEVICE_ATTR(energy1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
-static SENSOR_DEVICE_ATTR(energy1_input, S_IRUGO, vexpress_hwmon_u64_show,
-		NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(energy1_input, vexpress_hwmon_u64, 1);
 static struct attribute *vexpress_hwmon_attrs_energy[] = {
 	&dev_attr_energy1_label.attr,
 	&sensor_dev_attr_energy1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -214,8 +214,8 @@ static DEVICE_ATTR(cpu0_vid, S_IRUGO, ge
 #define IN_FROM_REG(val) ((val) * 19)
 #define IN_TO_REG(val) clamp_val((((val) + 9) / 19), 0, 255)

-static ssize_t get_in_input(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t in_input_show(struct device *dev,
+		             struct device_attribute *attr, char *buf)
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -227,8 +227,8 @@ static ssize_t get_in_input(struct devic
 		return sprintf(buf, "%d\n", IN_FROM_REG(r));
 }

-static ssize_t get_in_min(struct device *dev, struct device_attribute *attr,
-			  char *buf)
+static ssize_t in_min_show(struct device *dev, struct device_attribute *attr,
+		           char *buf)
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -240,8 +240,8 @@ static ssize_t get_in_min(struct device
 		return sprintf(buf, "%d\n", IN_FROM_REG(r));
 }

-static ssize_t get_in_max(struct device *dev, struct device_attribute *attr,
-			  char *buf)
+static ssize_t in_max_show(struct device *dev, struct device_attribute *attr,
+		           char *buf)
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -253,8 +253,8 @@ static ssize_t get_in_max(struct device
 		return sprintf(buf, "%d\n", IN_FROM_REG(r));
 }

-static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t in_min_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct gl520_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -287,8 +287,8 @@ static ssize_t set_in_min(struct device
 	return count;
 }

-static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t in_max_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct gl520_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -321,39 +321,29 @@ static ssize_t set_in_max(struct device
 	return count;
 }

-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, get_in_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, get_in_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, get_in_input, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, get_in_input, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, get_in_input, NULL, 4);
-static SENSOR_DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
-		get_in_min, set_in_min, 0);
-static SENSOR_DEVICE_ATTR(in1_min, S_IRUGO | S_IWUSR,
-		get_in_min, set_in_min, 1);
-static SENSOR_DEVICE_ATTR(in2_min, S_IRUGO | S_IWUSR,
-		get_in_min, set_in_min, 2);
-static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO | S_IWUSR,
-		get_in_min, set_in_min, 3);
-static SENSOR_DEVICE_ATTR(in4_min, S_IRUGO | S_IWUSR,
-		get_in_min, set_in_min, 4);
-static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
-		get_in_max, set_in_max, 0);
-static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO | S_IWUSR,
-		get_in_max, set_in_max, 1);
-static SENSOR_DEVICE_ATTR(in2_max, S_IRUGO | S_IWUSR,
-		get_in_max, set_in_max, 2);
-static SENSOR_DEVICE_ATTR(in3_max, S_IRUGO | S_IWUSR,
-		get_in_max, set_in_max, 3);
-static SENSOR_DEVICE_ATTR(in4_max, S_IRUGO | S_IWUSR,
-		get_in_max, set_in_max, 4);
+static SENSOR_DEVICE_ATTR_RO(in0_input, in_input, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_input, in_input, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, in_input, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, in_input, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, in_input, 4);
+static SENSOR_DEVICE_ATTR_RW(in0_min, in_min, 0);
+static SENSOR_DEVICE_ATTR_RW(in1_min, in_min, 1);
+static SENSOR_DEVICE_ATTR_RW(in2_min, in_min, 2);
+static SENSOR_DEVICE_ATTR_RW(in3_min, in_min, 3);
+static SENSOR_DEVICE_ATTR_RW(in4_min, in_min, 4);
+static SENSOR_DEVICE_ATTR_RW(in0_max, in_max, 0);
+static SENSOR_DEVICE_ATTR_RW(in1_max, in_max, 1);
+static SENSOR_DEVICE_ATTR_RW(in2_max, in_max, 2);
+static SENSOR_DEVICE_ATTR_RW(in3_max, in_max, 3);
+static SENSOR_DEVICE_ATTR_RW(in4_max, in_max, 4);

 #define DIV_FROM_REG(val) (1 << (val))
 #define FAN_FROM_REG(val, div) ((val) == 0 ? 0 : (480000 / ((val) << (div))))
 #define FAN_TO_REG(val, div) ((val) <= 0 ? 0 : \
 	clamp_val((480000 + ((val) << ((div)-1))) / ((val) << (div)), 1, 255))

-static ssize_t get_fan_input(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t fan_input_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -362,8 +352,8 @@ static ssize_t get_fan_input(struct devi
 						 data->fan_div[n]));
 }

-static ssize_t get_fan_min(struct device *dev, struct device_attribute *attr,
-			   char *buf)
+static ssize_t fan_min_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -372,8 +362,8 @@ static ssize_t get_fan_min(struct device
 						 data->fan_div[n]));
 }

-static ssize_t get_fan_div(struct device *dev, struct device_attribute *attr,
-			   char *buf)
+static ssize_t fan_div_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -388,8 +378,9 @@ static ssize_t get_fan_off(struct device
 	return sprintf(buf, "%d\n", data->fan_off);
 }

-static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t fan_min_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct gl520_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -427,8 +418,9 @@ static ssize_t set_fan_min(struct device
 	return count;
 }

-static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t fan_div_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct gl520_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -500,16 +492,12 @@ static ssize_t set_fan_off(struct device
 	return count;
 }

-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, get_fan_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, get_fan_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO | S_IWUSR,
-		get_fan_min, set_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO | S_IWUSR,
-		get_fan_min, set_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
-		get_fan_div, set_fan_div, 0);
-static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
-		get_fan_div, set_fan_div, 1);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1);
+static SENSOR_DEVICE_ATTR_RW(fan1_min, fan_min, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_min, fan_min, 1);
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 1);
 static DEVICE_ATTR(fan1_off, S_IRUGO | S_IWUSR,
 		get_fan_off, set_fan_off);

@@ -517,8 +505,8 @@ static DEVICE_ATTR(fan1_off, S_IRUGO | S
 #define TEMP_TO_REG(val) clamp_val(((((val) < 0 ? \
 			(val) - 500 : (val) + 500) / 1000) + 130), 0, 255)

-static ssize_t get_temp_input(struct device *dev, struct device_attribute *attr,
-			      char *buf)
+static ssize_t temp_input_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -526,8 +514,8 @@ static ssize_t get_temp_input(struct dev
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_input[n]));
 }

-static ssize_t get_temp_max(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t temp_max_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -535,8 +523,8 @@ static ssize_t get_temp_max(struct devic
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[n]));
 }

-static ssize_t get_temp_max_hyst(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t temp_max_hyst_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	int n = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -544,8 +532,9 @@ static ssize_t get_temp_max_hyst(struct
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max_hyst[n]));
 }

-static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t temp_max_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
 {
 	struct gl520_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -564,8 +553,9 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }

-static ssize_t set_temp_max_hyst(struct device *dev, struct device_attribute
-				 *attr, const char *buf, size_t count)
+static ssize_t temp_max_hyst_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
 {
 	struct gl520_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -585,16 +575,12 @@ static ssize_t set_temp_max_hyst(struct
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, get_temp_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, get_temp_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
-		get_temp_max, set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR,
-		get_temp_max, set_temp_max, 1);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR,
-		get_temp_max_hyst, set_temp_max_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO | S_IWUSR,
-		get_temp_max_hyst, set_temp_max_hyst, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_input, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp_max_hyst, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_max_hyst, temp_max_hyst, 1);

 static ssize_t get_alarms(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -667,8 +653,8 @@ static DEVICE_ATTR(beep_enable, S_IRUGO
 static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR,
 		get_beep_mask, set_beep_mask);

-static ssize_t get_alarm(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	int bit_nr = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -676,18 +662,18 @@ static ssize_t get_alarm(struct device *
 	return sprintf(buf, "%d\n", (data->alarms >> bit_nr) & 1);
 }

-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, get_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, get_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, get_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, get_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, get_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, get_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, get_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, get_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, get_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 7);

-static ssize_t get_beep(struct device *dev, struct device_attribute *attr,
-			char *buf)
+static ssize_t beep_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct gl520_data *data = gl520_update_device(dev);
@@ -695,8 +681,8 @@ static ssize_t get_beep(struct device *d
 	return sprintf(buf, "%d\n", (data->beep_mask >> bitnr) & 1);
 }

-static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t beep_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct gl520_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -722,15 +708,15 @@ static ssize_t set_beep(struct device *d
 	return count;
 }

-static SENSOR_DEVICE_ATTR(in0_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 0);
-static SENSOR_DEVICE_ATTR(in1_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 1);
-static SENSOR_DEVICE_ATTR(in2_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 2);
-static SENSOR_DEVICE_ATTR(in3_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 3);
-static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 4);
-static SENSOR_DEVICE_ATTR(fan1_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 5);
-static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 6);
-static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 7);
-static SENSOR_DEVICE_ATTR(in4_beep, S_IRUGO | S_IWUSR, get_beep, set_beep, 7);
+static SENSOR_DEVICE_ATTR_RW(in0_beep, beep, 0);
+static SENSOR_DEVICE_ATTR_RW(in1_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RW(in2_beep, beep, 2);
+static SENSOR_DEVICE_ATTR_RW(in3_beep, beep, 3);
+static SENSOR_DEVICE_ATTR_RW(temp1_beep, beep, 4);
+static SENSOR_DEVICE_ATTR_RW(fan1_beep, beep, 5);
+static SENSOR_DEVICE_ATTR_RW(fan2_beep, beep, 6);
+static SENSOR_DEVICE_ATTR_RW(temp2_beep, beep, 7);
+static SENSOR_DEVICE_ATTR_RW(in4_beep, beep, 7);

 static struct attribute *gl520_attributes[] = {
 	&dev_attr_cpu0_vid.attr,
diff -u -p a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -94,7 +94,7 @@ static ssize_t show_temp_max(struct devi
 	return sprintf(buf, "%d\n", 70 * 1000);
 }

-static ssize_t show_temp_crit(struct device *dev,
+static ssize_t temp_crit_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -112,8 +112,8 @@ static ssize_t show_temp_crit(struct dev

 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
 static DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit, temp_crit, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_hyst, temp_crit, 1);

 static umode_t k10temp_is_visible(struct kobject *kobj,
 				  struct attribute *attr, int index)
diff -u -p a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -158,7 +158,7 @@ static struct lm83_data *lm83_update_dev
  * Sysfs stuff
  */

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -166,8 +166,9 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm83_data *data = dev_get_drvdata(dev);
@@ -195,7 +196,7 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%d\n", data->alarms);
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute
+static ssize_t alarm_show(struct device *dev, struct device_attribute
 			  *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -205,36 +206,31 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp,
-	set_temp, 4);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp,
-	set_temp, 5);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp,
-	set_temp, 6);
-static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp,
-	set_temp, 7);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp3_crit, S_IWUSR | S_IRUGO, show_temp,
-	set_temp, 8);
-static SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO, show_temp, NULL, 8);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 3);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, 4);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp, 5);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, temp, 6);
+static SENSOR_DEVICE_ATTR_RW(temp4_max, temp, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit, temp, 8);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit, temp, 8);
+static SENSOR_DEVICE_ATTR_RW(temp3_crit, temp, 8);
+static SENSOR_DEVICE_ATTR_RO(temp4_crit, temp, 8);

 /* Individual alarm files */
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp4_crit_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 15);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(temp4_crit_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(temp4_fault, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_alarm, alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 13);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 15);
 /* Raw alarm file for compatibility */
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

diff -u -p a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -461,7 +461,7 @@ static ssize_t set_num_temp_sensors(stru
 	return count;
 }

-static ssize_t show_temp_min(struct device *dev,
+static ssize_t temp_min_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -470,10 +470,9 @@ static ssize_t show_temp_min(struct devi
 	return sprintf(buf, "%d\n", 1000 * data->temp_min[attr->index]);
 }

-static ssize_t set_temp_min(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t temp_min_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
@@ -495,7 +494,7 @@ static ssize_t set_temp_min(struct devic
 	return count;
 }

-static ssize_t show_temp_max(struct device *dev,
+static ssize_t temp_max_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -504,10 +503,9 @@ static ssize_t show_temp_max(struct devi
 	return sprintf(buf, "%d\n", 1000 * data->temp_max[attr->index]);
 }

-static ssize_t set_temp_max(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t temp_max_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
@@ -529,7 +527,7 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -568,7 +566,7 @@ static ssize_t set_alarm_mask(struct dev
 	return count;
 }

-static ssize_t show_fan_max(struct device *dev,
+static ssize_t fan_max_show(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
@@ -582,9 +580,9 @@ static ssize_t show_fan_max(struct devic
 		return sprintf(buf, "0\n");
 }

-static ssize_t set_fan_max(struct device *dev,
-			   struct device_attribute *devattr,
-			   const char *buf, size_t count)
+static ssize_t fan_max_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
@@ -605,7 +603,7 @@ static ssize_t set_fan_max(struct device
 	return count;
 }

-static ssize_t show_fan_min(struct device *dev,
+static ssize_t fan_min_show(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
@@ -619,9 +617,9 @@ static ssize_t show_fan_min(struct devic
 		return sprintf(buf, "0\n");
 }

-static ssize_t set_fan_min(struct device *dev,
-			   struct device_attribute *devattr,
-			   const char *buf, size_t count)
+static ssize_t fan_min_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
@@ -642,7 +640,7 @@ static ssize_t set_fan_min(struct device
 	return count;
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
+static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -655,7 +653,7 @@ static ssize_t show_fan(struct device *d
 		return sprintf(buf, "0\n");
 }

-static ssize_t show_force_pwm_max(struct device *dev,
+static ssize_t force_pwm_max_show(struct device *dev,
 				  struct device_attribute *devattr,
 				  char *buf)
 {
@@ -663,10 +661,9 @@ static ssize_t show_force_pwm_max(struct
 	return sprintf(buf, "%d\n", data->force_pwm_max);
 }

-static ssize_t set_force_pwm_max(struct device *dev,
-				 struct device_attribute *devattr,
-				 const char *buf,
-				 size_t count)
+static ssize_t force_pwm_max_store(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
 {
 	struct adt7470_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -689,7 +686,7 @@ static ssize_t set_force_pwm_max(struct
 	return count;
 }

-static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
+static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -697,8 +694,8 @@ static ssize_t show_pwm(struct device *d
 	return sprintf(buf, "%d\n", data->pwm[attr->index]);
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
@@ -782,7 +779,7 @@ static ssize_t set_pwm_freq(struct devic
 	return count;
 }

-static ssize_t show_pwm_max(struct device *dev,
+static ssize_t pwm_max_show(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
@@ -791,10 +788,9 @@ static ssize_t show_pwm_max(struct devic
 	return sprintf(buf, "%d\n", data->pwm_max[attr->index]);
 }

-static ssize_t set_pwm_max(struct device *dev,
-			   struct device_attribute *devattr,
-			   const char *buf,
-			   size_t count)
+static ssize_t pwm_max_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
@@ -815,7 +811,7 @@ static ssize_t set_pwm_max(struct device
 	return count;
 }

-static ssize_t show_pwm_min(struct device *dev,
+static ssize_t pwm_min_show(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
@@ -824,10 +820,9 @@ static ssize_t show_pwm_min(struct devic
 	return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
 }

-static ssize_t set_pwm_min(struct device *dev,
-			   struct device_attribute *devattr,
-			   const char *buf,
-			   size_t count)
+static ssize_t pwm_min_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
@@ -848,7 +843,7 @@ static ssize_t set_pwm_min(struct device
 	return count;
 }

-static ssize_t show_pwm_tmax(struct device *dev,
+static ssize_t pwm_tmax_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -858,7 +853,7 @@ static ssize_t show_pwm_tmax(struct devi
 	return sprintf(buf, "%d\n", 1000 * (20 + data->pwm_tmin[attr->index]));
 }

-static ssize_t show_pwm_tmin(struct device *dev,
+static ssize_t pwm_tmin_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -867,10 +862,9 @@ static ssize_t show_pwm_tmin(struct devi
 	return sprintf(buf, "%d\n", 1000 * data->pwm_tmin[attr->index]);
 }

-static ssize_t set_pwm_tmin(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t pwm_tmin_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
@@ -892,7 +886,7 @@ static ssize_t set_pwm_tmin(struct devic
 	return count;
 }

-static ssize_t show_pwm_auto(struct device *dev,
+static ssize_t pwm_auto_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -901,10 +895,9 @@ static ssize_t show_pwm_auto(struct devi
 	return sprintf(buf, "%d\n", 1 + data->pwm_automatic[attr->index]);
 }

-static ssize_t set_pwm_auto(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t pwm_auto_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
@@ -939,7 +932,7 @@ static ssize_t set_pwm_auto(struct devic
 	return count;
 }

-static ssize_t show_pwm_auto_temp(struct device *dev,
+static ssize_t pwm_auto_temp_show(struct device *dev,
 				  struct device_attribute *devattr,
 				  char *buf)
 {
@@ -962,10 +955,9 @@ static int cvt_auto_temp(int input)
 	return ilog2(input) + 1;
 }

-static ssize_t set_pwm_auto_temp(struct device *dev,
-				 struct device_attribute *devattr,
-				 const char *buf,
-				 size_t count)
+static ssize_t pwm_auto_temp_store(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7470_data *data = dev_get_drvdata(dev);
@@ -999,7 +991,7 @@ static ssize_t set_pwm_auto_temp(struct
 	return count;
 }

-static ssize_t show_alarm(struct device *dev,
+static ssize_t alarm_show(struct device *dev,
 			  struct device_attribute *devattr,
 			  char *buf)
 {
@@ -1019,175 +1011,108 @@ static DEVICE_ATTR(num_temp_sensors, S_I
 static DEVICE_ATTR(auto_update_interval, S_IWUSR | S_IRUGO,
 		   show_auto_update_interval, set_auto_update_interval);

-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 1);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 2);
-static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 3);
-static SENSOR_DEVICE_ATTR(temp5_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 4);
-static SENSOR_DEVICE_ATTR(temp6_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 5);
-static SENSOR_DEVICE_ATTR(temp7_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 6);
-static SENSOR_DEVICE_ATTR(temp8_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 7);
-static SENSOR_DEVICE_ATTR(temp9_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 8);
-static SENSOR_DEVICE_ATTR(temp10_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 9);
-
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 0);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 1);
-static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 2);
-static SENSOR_DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 3);
-static SENSOR_DEVICE_ATTR(temp5_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 4);
-static SENSOR_DEVICE_ATTR(temp6_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 5);
-static SENSOR_DEVICE_ATTR(temp7_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 6);
-static SENSOR_DEVICE_ATTR(temp8_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 7);
-static SENSOR_DEVICE_ATTR(temp9_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 8);
-static SENSOR_DEVICE_ATTR(temp10_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 9);
-
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp7_input, S_IRUGO, show_temp, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, show_temp, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp9_input, S_IRUGO, show_temp, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp10_input, S_IRUGO, show_temp, NULL, 9);
-
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7470_R1T_ALARM);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7470_R2T_ALARM);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7470_R3T_ALARM);
-static SENSOR_DEVICE_ATTR(temp4_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7470_R4T_ALARM);
-static SENSOR_DEVICE_ATTR(temp5_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7470_R5T_ALARM);
-static SENSOR_DEVICE_ATTR(temp6_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7470_R6T_ALARM);
-static SENSOR_DEVICE_ATTR(temp7_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7470_R7T_ALARM);
-static SENSOR_DEVICE_ATTR(temp8_alarm, S_IRUGO, show_alarm, NULL,
-			  ALARM2(ADT7470_R8T_ALARM));
-static SENSOR_DEVICE_ATTR(temp9_alarm, S_IRUGO, show_alarm, NULL,
-			  ALARM2(ADT7470_R9T_ALARM));
-static SENSOR_DEVICE_ATTR(temp10_alarm, S_IRUGO, show_alarm, NULL,
-			  ALARM2(ADT7470_R10T_ALARM));
-
-static SENSOR_DEVICE_ATTR(fan1_max, S_IWUSR | S_IRUGO, show_fan_max,
-		    set_fan_max, 0);
-static SENSOR_DEVICE_ATTR(fan2_max, S_IWUSR | S_IRUGO, show_fan_max,
-		    set_fan_max, 1);
-static SENSOR_DEVICE_ATTR(fan3_max, S_IWUSR | S_IRUGO, show_fan_max,
-		    set_fan_max, 2);
-static SENSOR_DEVICE_ATTR(fan4_max, S_IWUSR | S_IRUGO, show_fan_max,
-		    set_fan_max, 3);
-
-static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 2);
-static SENSOR_DEVICE_ATTR(fan4_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 3);
-
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3);
-
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL,
-			  ALARM2(ADT7470_FAN1_ALARM));
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL,
-			  ALARM2(ADT7470_FAN2_ALARM));
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL,
-			  ALARM2(ADT7470_FAN3_ALARM));
-static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL,
-			  ALARM2(ADT7470_FAN4_ALARM));
-
-static SENSOR_DEVICE_ATTR(force_pwm_max, S_IWUSR | S_IRUGO,
-		    show_force_pwm_max, set_force_pwm_max, 0);
-
-static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1);
-static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2);
-static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 3);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, temp_max, 2);
+static SENSOR_DEVICE_ATTR_RW(temp4_max, temp_max, 3);
+static SENSOR_DEVICE_ATTR_RW(temp5_max, temp_max, 4);
+static SENSOR_DEVICE_ATTR_RW(temp6_max, temp_max, 5);
+static SENSOR_DEVICE_ATTR_RW(temp7_max, temp_max, 6);
+static SENSOR_DEVICE_ATTR_RW(temp8_max, temp_max, 7);
+static SENSOR_DEVICE_ATTR_RW(temp9_max, temp_max, 8);
+static SENSOR_DEVICE_ATTR_RW(temp10_max, temp_max, 9);
+
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp_min, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_min, temp_min, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_min, temp_min, 2);
+static SENSOR_DEVICE_ATTR_RW(temp4_min, temp_min, 3);
+static SENSOR_DEVICE_ATTR_RW(temp5_min, temp_min, 4);
+static SENSOR_DEVICE_ATTR_RW(temp6_min, temp_min, 5);
+static SENSOR_DEVICE_ATTR_RW(temp7_min, temp_min, 6);
+static SENSOR_DEVICE_ATTR_RW(temp8_min, temp_min, 7);
+static SENSOR_DEVICE_ATTR_RW(temp9_min, temp_min, 8);
+static SENSOR_DEVICE_ATTR_RW(temp10_min, temp_min, 9);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_input, temp, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_input, temp, 5);
+static SENSOR_DEVICE_ATTR_RO(temp7_input, temp, 6);
+static SENSOR_DEVICE_ATTR_RO(temp8_input, temp, 7);
+static SENSOR_DEVICE_ATTR_RO(temp9_input, temp, 8);
+static SENSOR_DEVICE_ATTR_RO(temp10_input, temp, 9);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, ADT7470_R1T_ALARM);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, ADT7470_R2T_ALARM);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, ADT7470_R3T_ALARM);
+static SENSOR_DEVICE_ATTR_RO(temp4_alarm, alarm, ADT7470_R4T_ALARM);
+static SENSOR_DEVICE_ATTR_RO(temp5_alarm, alarm, ADT7470_R5T_ALARM);
+static SENSOR_DEVICE_ATTR_RO(temp6_alarm, alarm, ADT7470_R6T_ALARM);
+static SENSOR_DEVICE_ATTR_RO(temp7_alarm, alarm, ADT7470_R7T_ALARM);
+static SENSOR_DEVICE_ATTR_RO(temp8_alarm, alarm, ALARM2(ADT7470_R8T_ALARM));
+static SENSOR_DEVICE_ATTR_RO(temp9_alarm, alarm, ALARM2(ADT7470_R9T_ALARM));
+static SENSOR_DEVICE_ATTR_RO(temp10_alarm, alarm, ALARM2(ADT7470_R10T_ALARM));
+
+static SENSOR_DEVICE_ATTR_RW(fan1_max, fan_max, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_max, fan_max, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_max, fan_max, 2);
+static SENSOR_DEVICE_ATTR_RW(fan4_max, fan_max, 3);
+
+static SENSOR_DEVICE_ATTR_RW(fan1_min, fan_min, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_min, fan_min, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_min, fan_min, 2);
+static SENSOR_DEVICE_ATTR_RW(fan4_min, fan_min, 3);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan, 3);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, ALARM2(ADT7470_FAN1_ALARM));
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, ALARM2(ADT7470_FAN2_ALARM));
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, ALARM2(ADT7470_FAN3_ALARM));
+static SENSOR_DEVICE_ATTR_RO(fan4_alarm, alarm, ALARM2(ADT7470_FAN4_ALARM));
+
+static SENSOR_DEVICE_ATTR_RW(force_pwm_max, force_pwm_max, 0);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4, pwm, 3);

 static DEVICE_ATTR(pwm1_freq, S_IWUSR | S_IRUGO, show_pwm_freq, set_pwm_freq);

-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 1);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 2);
-static SENSOR_DEVICE_ATTR(pwm4_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 3);
-
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 1);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 2);
-static SENSOR_DEVICE_ATTR(pwm4_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 3);
-
-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 1);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 2);
-static SENSOR_DEVICE_ATTR(pwm4_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 3);
-
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp, S_IRUGO, show_pwm_tmax,
-		    NULL, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point2_temp, S_IRUGO, show_pwm_tmax,
-		    NULL, 1);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point2_temp, S_IRUGO, show_pwm_tmax,
-		    NULL, 2);
-static SENSOR_DEVICE_ATTR(pwm4_auto_point2_temp, S_IRUGO, show_pwm_tmax,
-		    NULL, 3);
-
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 0);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 1);
-static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 2);
-static SENSOR_DEVICE_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 3);
-
-static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 1);
-static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 2);
-static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 3);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm_min, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point1_pwm, pwm_min, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point1_pwm, pwm_min, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_auto_point1_pwm, pwm_min, 3);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm_max, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point2_pwm, pwm_max, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point2_pwm, pwm_max, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_auto_point2_pwm, pwm_max, 3);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_temp, pwm_tmin, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point1_temp, pwm_tmin, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point1_temp, pwm_tmin, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_auto_point1_temp, pwm_tmin, 3);
+
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point2_temp, pwm_tmax, 0);
+static SENSOR_DEVICE_ATTR_RO(pwm2_auto_point2_temp, pwm_tmax, 1);
+static SENSOR_DEVICE_ATTR_RO(pwm3_auto_point2_temp, pwm_tmax, 2);
+static SENSOR_DEVICE_ATTR_RO(pwm4_auto_point2_temp, pwm_tmax, 3);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_auto, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_auto, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwm_auto, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_enable, pwm_auto, 3);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_channels_temp, pwm_auto_temp, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_channels_temp, pwm_auto_temp, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_channels_temp, pwm_auto_temp, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_auto_channels_temp, pwm_auto_temp, 3);

 static struct attribute *adt7470_attrs[] = {
 	&dev_attr_alarm_mask.attr,
diff -u -p a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -140,7 +140,7 @@ done:
 	return ret;
 }

-static ssize_t adc128_show_in(struct device *dev, struct device_attribute *attr,
+static ssize_t adc128_in_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct adc128_data *data = adc128_update_device(dev);
@@ -155,8 +155,9 @@ static ssize_t adc128_show_in(struct dev
 	return sprintf(buf, "%d\n", val);
 }

-static ssize_t adc128_set_in(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t adc128_in_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
 {
 	struct adc128_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr_2(attr)->index;
@@ -180,7 +181,7 @@ static ssize_t adc128_set_in(struct devi
 	return count;
 }

-static ssize_t adc128_show_temp(struct device *dev,
+static ssize_t adc128_temp_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct adc128_data *data = adc128_update_device(dev);
@@ -194,9 +195,9 @@ static ssize_t adc128_show_temp(struct d
 	return sprintf(buf, "%d\n", temp * 500);/* 0.5 degrees C resolution */
 }

-static ssize_t adc128_set_temp(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t adc128_temp_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct adc128_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr(attr)->index;
@@ -220,7 +221,7 @@ static ssize_t adc128_set_temp(struct de
 	return count;
 }

-static ssize_t adc128_show_alarm(struct device *dev,
+static ssize_t adc128_alarm_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	struct adc128_data *data = adc128_update_device(dev);
@@ -240,69 +241,46 @@ static ssize_t adc128_show_alarm(struct
 	return sprintf(buf, "%u\n", !!(alarms & mask));
 }

-static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO,
-			    adc128_show_in, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(in0_min, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 0, 1);
-static SENSOR_DEVICE_ATTR_2(in0_max, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 0, 2);
-
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO,
-			    adc128_show_in, NULL, 1, 0);
-static SENSOR_DEVICE_ATTR_2(in1_min, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 1, 1);
-static SENSOR_DEVICE_ATTR_2(in1_max, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 1, 2);
-
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO,
-			    adc128_show_in, NULL, 2, 0);
-static SENSOR_DEVICE_ATTR_2(in2_min, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 2, 1);
-static SENSOR_DEVICE_ATTR_2(in2_max, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 2, 2);
-
-static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO,
-			    adc128_show_in, NULL, 3, 0);
-static SENSOR_DEVICE_ATTR_2(in3_min, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 3, 1);
-static SENSOR_DEVICE_ATTR_2(in3_max, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 3, 2);
-
-static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO,
-			    adc128_show_in, NULL, 4, 0);
-static SENSOR_DEVICE_ATTR_2(in4_min, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 4, 1);
-static SENSOR_DEVICE_ATTR_2(in4_max, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 4, 2);
-
-static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO,
-			    adc128_show_in, NULL, 5, 0);
-static SENSOR_DEVICE_ATTR_2(in5_min, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 5, 1);
-static SENSOR_DEVICE_ATTR_2(in5_max, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 5, 2);
-
-static SENSOR_DEVICE_ATTR_2(in6_input, S_IRUGO,
-			    adc128_show_in, NULL, 6, 0);
-static SENSOR_DEVICE_ATTR_2(in6_min, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 6, 1);
-static SENSOR_DEVICE_ATTR_2(in6_max, S_IWUSR | S_IRUGO,
-			    adc128_show_in, adc128_set_in, 6, 2);
-
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, adc128_show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
-			  adc128_show_temp, adc128_set_temp, 1);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
-			  adc128_show_temp, adc128_set_temp, 2);
-
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, adc128_show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, adc128_show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, adc128_show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, adc128_show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, adc128_show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, adc128_show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, adc128_show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, adc128_show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR_2_RO(in0_input, adc128_in, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in0_min, adc128_in, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in0_max, adc128_in, 0, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in1_input, adc128_in, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in1_min, adc128_in, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in1_max, adc128_in, 1, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in2_input, adc128_in, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in2_min, adc128_in, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in2_max, adc128_in, 2, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in3_input, adc128_in, 3, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in3_min, adc128_in, 3, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in3_max, adc128_in, 3, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in4_input, adc128_in, 4, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in4_min, adc128_in, 4, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in4_max, adc128_in, 4, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in5_input, adc128_in, 5, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in5_min, adc128_in, 5, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in5_max, adc128_in, 5, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in6_input, adc128_in, 6, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in6_min, adc128_in, 6, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in6_max, adc128_in, 6, 2);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, adc128_temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, adc128_temp, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, adc128_temp, 2);
+
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, adc128_alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, adc128_alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, adc128_alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, adc128_alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, adc128_alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, adc128_alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, adc128_alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, adc128_alarm, 7);

 static struct attribute *adc128_attrs[] = {
 	&sensor_dev_attr_in0_min.dev_attr.attr,
diff -u -p a/drivers/hwmon/ltc4222.c b/drivers/hwmon/ltc4222.c
--- a/drivers/hwmon/ltc4222.c
+++ b/drivers/hwmon/ltc4222.c
@@ -94,7 +94,7 @@ static int ltc4222_get_value(struct devi
 	return val;
 }

-static ssize_t ltc4222_show_value(struct device *dev,
+static ssize_t ltc4222_value_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -106,7 +106,7 @@ static ssize_t ltc4222_show_value(struct
 	return snprintf(buf, PAGE_SIZE, "%d\n", value);
 }

-static ssize_t ltc4222_show_bool(struct device *dev,
+static ssize_t ltc4222_bool_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(da);
@@ -125,45 +125,39 @@ static ssize_t ltc4222_show_bool(struct
 }

 /* Voltages */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4222_show_value, NULL,
-			  LTC4222_SOURCE1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4222_show_value, NULL,
-			  LTC4222_ADIN1);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, ltc4222_show_value, NULL,
-			  LTC4222_SOURCE2);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, ltc4222_show_value, NULL,
-			  LTC4222_ADIN2);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ltc4222_value, LTC4222_SOURCE1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, ltc4222_value, LTC4222_ADIN1);
+static SENSOR_DEVICE_ATTR_RO(in3_input, ltc4222_value, LTC4222_SOURCE2);
+static SENSOR_DEVICE_ATTR_RO(in4_input, ltc4222_value, LTC4222_ADIN2);

 /*
  * Voltage alarms
  * UV/OV faults are associated with the input voltage, and power bad and fet
  * faults are associated with the output voltage.
  */
-static SENSOR_DEVICE_ATTR_2(in1_min_alarm, S_IRUGO, ltc4222_show_bool, NULL,
-			    LTC4222_FAULT1, FAULT_UV);
-static SENSOR_DEVICE_ATTR_2(in1_max_alarm, S_IRUGO, ltc4222_show_bool, NULL,
-			    LTC4222_FAULT1, FAULT_OV);
-static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, ltc4222_show_bool, NULL,
-			    LTC4222_FAULT1, FAULT_POWER_BAD | FAULT_FET_BAD);
-
-static SENSOR_DEVICE_ATTR_2(in3_min_alarm, S_IRUGO, ltc4222_show_bool, NULL,
-			    LTC4222_FAULT2, FAULT_UV);
-static SENSOR_DEVICE_ATTR_2(in3_max_alarm, S_IRUGO, ltc4222_show_bool, NULL,
-			    LTC4222_FAULT2, FAULT_OV);
-static SENSOR_DEVICE_ATTR_2(in4_alarm, S_IRUGO, ltc4222_show_bool, NULL,
-			    LTC4222_FAULT2, FAULT_POWER_BAD | FAULT_FET_BAD);
+static SENSOR_DEVICE_ATTR_2_RO(in1_min_alarm, ltc4222_bool, LTC4222_FAULT1,
+			       FAULT_UV);
+static SENSOR_DEVICE_ATTR_2_RO(in1_max_alarm, ltc4222_bool, LTC4222_FAULT1,
+			       FAULT_OV);
+static SENSOR_DEVICE_ATTR_2_RO(in2_alarm, ltc4222_bool, LTC4222_FAULT1,
+			       FAULT_POWER_BAD | FAULT_FET_BAD);
+
+static SENSOR_DEVICE_ATTR_2_RO(in3_min_alarm, ltc4222_bool, LTC4222_FAULT2,
+			       FAULT_UV);
+static SENSOR_DEVICE_ATTR_2_RO(in3_max_alarm, ltc4222_bool, LTC4222_FAULT2,
+			       FAULT_OV);
+static SENSOR_DEVICE_ATTR_2_RO(in4_alarm, ltc4222_bool, LTC4222_FAULT2,
+			       FAULT_POWER_BAD | FAULT_FET_BAD);

 /* Current (via sense resistor) */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4222_show_value, NULL,
-			  LTC4222_SENSE1);
-static SENSOR_DEVICE_ATTR(curr2_input, S_IRUGO, ltc4222_show_value, NULL,
-			  LTC4222_SENSE2);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ltc4222_value, LTC4222_SENSE1);
+static SENSOR_DEVICE_ATTR_RO(curr2_input, ltc4222_value, LTC4222_SENSE2);

 /* Overcurrent alarm */
-static SENSOR_DEVICE_ATTR_2(curr1_max_alarm, S_IRUGO, ltc4222_show_bool, NULL,
-			    LTC4222_FAULT1, FAULT_OC);
-static SENSOR_DEVICE_ATTR_2(curr2_max_alarm, S_IRUGO, ltc4222_show_bool, NULL,
-			    LTC4222_FAULT2, FAULT_OC);
+static SENSOR_DEVICE_ATTR_2_RO(curr1_max_alarm, ltc4222_bool, LTC4222_FAULT1,
+			       FAULT_OC);
+static SENSOR_DEVICE_ATTR_2_RO(curr2_max_alarm, ltc4222_bool, LTC4222_FAULT2,
+			       FAULT_OC);

 static struct attribute *ltc4222_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -145,7 +145,7 @@ static struct max1619_data *max1619_upda
  * Sysfs stuff
  */

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -154,8 +154,9 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", temp_from_reg(data->temp[attr->index]));
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
-			   const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct max1619_data *data = dev_get_drvdata(dev);
@@ -180,7 +181,7 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%d\n", data->alarms);
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
@@ -188,22 +189,18 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%d\n", (data->alarms >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, t_input1);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, t_input2);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp, set_temp,
-			  t_low2);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp, set_temp,
-			  t_high2);
-static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp, set_temp,
-			  t_crit2);
-static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp,
-			  set_temp, t_hyst2);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, t_input1);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, t_input2);
+static SENSOR_DEVICE_ATTR_RW(temp2_min, temp, t_low2);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp, t_high2);
+static SENSOR_DEVICE_ATTR_RW(temp2_crit, temp, t_crit2);
+static SENSOR_DEVICE_ATTR_RW(temp2_crit_hyst, temp, t_hyst2);

 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 4);

 static struct attribute *max1619_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -109,7 +109,7 @@ static ssize_t show_name(struct device *
 }


-static ssize_t show_temp(struct device *dev,
+static ssize_t temp_show(struct device *dev,
 			 struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute_2 *attr =
@@ -129,10 +129,10 @@ static ssize_t show_temp(struct device *

 /* core, place */

-static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 1, 0);
-static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_input, temp, 1, 1);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);

 static const struct pci_device_id k8temp_ids[] = {
diff -u -p a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -341,21 +341,21 @@ show_alarms(struct device *dev, struct d
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

 static ssize_t
-show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
+alarm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_alarm, NULL, 14);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp1_fault, alarm, 14);

 static ssize_t
 show_vid(struct device *dev, struct device_attribute *attr, char *buf)
diff -u -p a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -211,7 +211,7 @@ static ssize_t show_name(struct device *
 	return snprintf(buf, PAGE_SIZE, "%s\n", DEVNAME);
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute
+static ssize_t temp_show(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -225,7 +225,7 @@ static ssize_t show_temp(struct device *
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }

-static ssize_t show_temp_fault(struct device *dev, struct device_attribute
+static ssize_t temp_fault_show(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -237,7 +237,7 @@ static ssize_t show_temp_fault(struct de
 	return snprintf(buf, PAGE_SIZE, "%d\n", data->temp[attr->index] == 0);
 }

-static ssize_t show_temp_max(struct device *dev, struct device_attribute
+static ssize_t temp_max_show(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -248,7 +248,7 @@ static ssize_t show_temp_max(struct devi
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }

-static ssize_t show_temp_crit(struct device *dev, struct device_attribute
+static ssize_t temp_crit_show(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -259,7 +259,7 @@ static ssize_t show_temp_crit(struct dev
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute
+static ssize_t fan_show(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -276,7 +276,7 @@ static ssize_t show_fan(struct device *d
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }

-static ssize_t show_fan_fault(struct device *dev, struct device_attribute
+static ssize_t fan_fault_show(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -289,7 +289,7 @@ static ssize_t show_fan_fault(struct dev
 			data->fan[attr->index] == 0xffff);
 }

-static ssize_t show_fan_min(struct device *dev, struct device_attribute
+static ssize_t fan_min_show(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -301,7 +301,7 @@ static ssize_t show_fan_min(struct devic
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }

-static ssize_t show_in(struct device *dev, struct device_attribute
+static ssize_t in_show(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -317,7 +317,7 @@ static ssize_t show_in(struct device *de
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }

-static ssize_t show_in_label(struct device *dev, struct device_attribute
+static ssize_t in_label_show(struct device *dev, struct device_attribute
 	*devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -327,61 +327,61 @@ static ssize_t show_in_label(struct devi
 }

 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp7_input, S_IRUGO, show_temp, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, show_temp, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_temp_fault, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_temp_fault, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_fault, S_IRUGO, show_temp_fault, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp7_fault, S_IRUGO, show_temp_fault, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp8_fault, S_IRUGO, show_temp_fault, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_temp_max, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO, show_temp_max, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO, show_temp_max, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_max, S_IRUGO, show_temp_max, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_max, S_IRUGO, show_temp_max, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp7_max, S_IRUGO, show_temp_max, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp8_max, S_IRUGO, show_temp_max, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp_crit, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO, show_temp_crit, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO, show_temp_crit, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_crit, S_IRUGO, show_temp_crit, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_crit, S_IRUGO, show_temp_crit, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp7_crit, S_IRUGO, show_temp_crit, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp8_crit, S_IRUGO, show_temp_crit, NULL, 7);
-
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3);
-static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, show_fan_fault, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_fault, S_IRUGO, show_fan_fault, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_fault, S_IRUGO, show_fan_fault, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_fault, S_IRUGO, show_fan_fault, NULL, 3);
-static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO, show_fan_min, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO, show_fan_min, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_min, S_IRUGO, show_fan_min, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_min, S_IRUGO, show_fan_min, NULL, 3);
-
-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in, NULL, 4);
-static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, show_in_label, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, show_in_label, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, show_in_label, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_in_label, NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_input, temp, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_input, temp, 5);
+static SENSOR_DEVICE_ATTR_RO(temp7_input, temp, 6);
+static SENSOR_DEVICE_ATTR_RO(temp8_input, temp, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_fault, temp_fault, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp_fault, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, temp_fault, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_fault, temp_fault, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_fault, temp_fault, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_fault, temp_fault, 5);
+static SENSOR_DEVICE_ATTR_RO(temp7_fault, temp_fault, 6);
+static SENSOR_DEVICE_ATTR_RO(temp8_fault, temp_fault, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_max, temp_max, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_max, temp_max, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_max, temp_max, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_max, temp_max, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_max, temp_max, 5);
+static SENSOR_DEVICE_ATTR_RO(temp7_max, temp_max, 6);
+static SENSOR_DEVICE_ATTR_RO(temp8_max, temp_max, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit, temp_crit, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit, temp_crit, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit, temp_crit, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_crit, temp_crit, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_crit, temp_crit, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_crit, temp_crit, 5);
+static SENSOR_DEVICE_ATTR_RO(temp7_crit, temp_crit, 6);
+static SENSOR_DEVICE_ATTR_RO(temp8_crit, temp_crit, 7);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan, 3);
+static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan_fault, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_fault, fan_fault, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_fault, fan_fault, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_fault, fan_fault, 3);
+static SENSOR_DEVICE_ATTR_RO(fan1_min, fan_min, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_min, fan_min, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_min, fan_min, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_min, fan_min, 3);
+
+static SENSOR_DEVICE_ATTR_RO(in0_input, in, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_input, in, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, in, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, in, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, in, 4);
+static SENSOR_DEVICE_ATTR_RO(in0_label, in_label, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_label, in_label, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_label, in_label, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_label, in_label, 3);

 static struct attribute *sch5627_attributes[] = {
 	&dev_attr_name.attr,
diff -u -p a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -95,7 +95,7 @@ static int s3c_hwmon_read_ch(struct devi
  * ADC channel. This does a conversion and returns the raw (un-scaled)
  * value returned from the hardware.
  */
-static ssize_t s3c_hwmon_show_raw(struct device *dev,
+static ssize_t s3c_hwmon_raw_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct s3c_hwmon *adc = platform_get_drvdata(to_platform_device(dev));
@@ -107,14 +107,14 @@ static ssize_t s3c_hwmon_show_raw(struct
 	return  (ret < 0) ? ret : snprintf(buf, PAGE_SIZE, "%d\n", ret);
 }

-static SENSOR_DEVICE_ATTR(adc0_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 0);
-static SENSOR_DEVICE_ATTR(adc1_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 1);
-static SENSOR_DEVICE_ATTR(adc2_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 2);
-static SENSOR_DEVICE_ATTR(adc3_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 3);
-static SENSOR_DEVICE_ATTR(adc4_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 4);
-static SENSOR_DEVICE_ATTR(adc5_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 5);
-static SENSOR_DEVICE_ATTR(adc6_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 6);
-static SENSOR_DEVICE_ATTR(adc7_raw, S_IRUGO, s3c_hwmon_show_raw, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(adc0_raw, s3c_hwmon_raw, 0);
+static SENSOR_DEVICE_ATTR_RO(adc1_raw, s3c_hwmon_raw, 1);
+static SENSOR_DEVICE_ATTR_RO(adc2_raw, s3c_hwmon_raw, 2);
+static SENSOR_DEVICE_ATTR_RO(adc3_raw, s3c_hwmon_raw, 3);
+static SENSOR_DEVICE_ATTR_RO(adc4_raw, s3c_hwmon_raw, 4);
+static SENSOR_DEVICE_ATTR_RO(adc5_raw, s3c_hwmon_raw, 5);
+static SENSOR_DEVICE_ATTR_RO(adc6_raw, s3c_hwmon_raw, 6);
+static SENSOR_DEVICE_ATTR_RO(adc7_raw, s3c_hwmon_raw, 7);

 static struct attribute *s3c_hwmon_attrs[9] = {
 	&sensor_dev_attr_adc0_raw.dev_attr.attr,
diff -u -p a/drivers/hwmon/ultra45_env.c b/drivers/hwmon/ultra45_env.c
--- a/drivers/hwmon/ultra45_env.c
+++ b/drivers/hwmon/ultra45_env.c
@@ -135,7 +135,7 @@ static ssize_t set_fan_speed(struct devi
 	return count;
 }

-static ssize_t show_fan_fault(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_fault_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	int fan_nr = to_sensor_dev_attr(attr)->index;
@@ -156,9 +156,9 @@ fan(2);
 fan(3);
 fan(4);

-static SENSOR_DEVICE_ATTR(psu_fan_fault, S_IRUGO, show_fan_fault, NULL, 6);
+static SENSOR_DEVICE_ATTR_RO(psu_fan_fault, fan_fault, 6);

-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	int temp_nr = to_sensor_dev_attr(attr)->index;
@@ -169,17 +169,17 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", ((int) val) - 64);
 }

-static SENSOR_DEVICE_ATTR(adt7462_local_temp, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(cpu0_temp, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(cpu1_temp, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(motherboard_temp, S_IRUGO, show_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(lm95221_local_temp, S_IRUGO, show_temp, NULL, 4);
-static SENSOR_DEVICE_ATTR(fire_temp, S_IRUGO, show_temp, NULL, 5);
-static SENSOR_DEVICE_ATTR(lsi1064_local_temp, S_IRUGO, show_temp, NULL, 6);
-static SENSOR_DEVICE_ATTR(front_panel_temp, S_IRUGO, show_temp, NULL, 7);
-static SENSOR_DEVICE_ATTR(psu_temp, S_IRUGO, show_temp, NULL, 13);
+static SENSOR_DEVICE_ATTR_RO(adt7462_local_temp, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(cpu0_temp, temp, 1);
+static SENSOR_DEVICE_ATTR_RO(cpu1_temp, temp, 2);
+static SENSOR_DEVICE_ATTR_RO(motherboard_temp, temp, 3);
+static SENSOR_DEVICE_ATTR_RO(lm95221_local_temp, temp, 4);
+static SENSOR_DEVICE_ATTR_RO(fire_temp, temp, 5);
+static SENSOR_DEVICE_ATTR_RO(lsi1064_local_temp, temp, 6);
+static SENSOR_DEVICE_ATTR_RO(front_panel_temp, temp, 7);
+static SENSOR_DEVICE_ATTR_RO(psu_temp, temp, 13);

-static ssize_t show_stat_bit(struct device *dev, struct device_attribute *attr,
+static ssize_t stat_bit_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	int index = to_sensor_dev_attr(attr)->index;
@@ -190,13 +190,12 @@ static ssize_t show_stat_bit(struct devi
 	return sprintf(buf, "%d\n", (val & (1 << index)) ? 1 : 0);
 }

-static SENSOR_DEVICE_ATTR(fan_failure, S_IRUGO, show_stat_bit, NULL, 0);
-static SENSOR_DEVICE_ATTR(env_bus_busy, S_IRUGO, show_stat_bit, NULL, 1);
-static SENSOR_DEVICE_ATTR(env_data_stale, S_IRUGO, show_stat_bit, NULL, 2);
-static SENSOR_DEVICE_ATTR(tpm_self_test_passed, S_IRUGO, show_stat_bit, NULL,
-			  3);
+static SENSOR_DEVICE_ATTR_RO(fan_failure, stat_bit, 0);
+static SENSOR_DEVICE_ATTR_RO(env_bus_busy, stat_bit, 1);
+static SENSOR_DEVICE_ATTR_RO(env_data_stale, stat_bit, 2);
+static SENSOR_DEVICE_ATTR_RO(tpm_self_test_passed, stat_bit, 3);

-static ssize_t show_fwver(struct device *dev, struct device_attribute *attr,
+static ssize_t fwver_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct env *p = dev_get_drvdata(dev);
@@ -206,15 +205,15 @@ static ssize_t show_fwver(struct device
 	return sprintf(buf, "%d\n", val >> 4);
 }

-static SENSOR_DEVICE_ATTR(firmware_version, S_IRUGO, show_fwver, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(firmware_version, fwver, 0);

-static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	return sprintf(buf, "ultra45\n");
 }

-static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(name, name, 0);

 static struct attribute *env_attributes[] = {
 	&sensor_dev_attr_fan0_speed.dev_attr.attr,
diff -u -p a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -296,8 +296,9 @@ static bool auto_mode_enabled(u8 pwm_ena
 	}
 }

-static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t fan_min_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -316,8 +317,9 @@ static ssize_t set_fan_min(struct device
 	return count;
 }

-static ssize_t set_fan_target(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t fan_target_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -341,8 +343,8 @@ static ssize_t set_fan_target(struct dev
 	return count;
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -365,7 +367,7 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }

-static ssize_t show_pwm_enable(struct device *dev, struct device_attribute
+static ssize_t pwm_enable_show(struct device *dev, struct device_attribute
 		*attr, char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -437,8 +439,9 @@ static int set_pwm_enable_direct(struct
 	return 0;
 }

-static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t pwm_enable_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -500,7 +503,7 @@ static ssize_t set_pwm_mode(struct devic
 	return count;
 }

-static ssize_t show_pwm(struct device *dev, struct device_attribute
+static ssize_t pwm_show(struct device *dev, struct device_attribute
 		*attr, char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -519,7 +522,7 @@ static ssize_t show_pwm_mode(struct devi
 #define VOLT_FROM_REG(val) ((val) * 8)
 #define VOLT_TO_REG(val) ((val) / 8)

-static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+static ssize_t in_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -527,7 +530,7 @@ static ssize_t show_in(struct device *de
 	return sprintf(buf, "%d\n", VOLT_FROM_REG(data->in[nr]));
 }

-static ssize_t show_in_max(struct device *dev, struct device_attribute *attr,
+static ssize_t in_max_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -535,7 +538,7 @@ static ssize_t show_in_max(struct device
 	return sprintf(buf, "%d\n", VOLT_FROM_REG(data->in_max[nr]));
 }

-static ssize_t show_in_min(struct device *dev, struct device_attribute *attr,
+static ssize_t in_min_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -543,8 +546,8 @@ static ssize_t show_in_min(struct device
 	return sprintf(buf, "%d\n", VOLT_FROM_REG(data->in_min[nr]));
 }

-static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t in_max_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -564,8 +567,8 @@ static ssize_t set_in_max(struct device
 	return count;
 }

-static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t in_min_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -588,7 +591,7 @@ static ssize_t set_in_min(struct device
 #define TEMP_TO_REG(val) ((val) / 1000)
 #define TEMP11_FROM_REG(reg)	((reg) / 32 * 125)

-static ssize_t show_temp11(struct device *dev, struct device_attribute *attr,
+static ssize_t temp11_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -596,7 +599,7 @@ static ssize_t show_temp11(struct device
 	return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->temp11[nr]));
 }

-static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_max_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -604,7 +607,7 @@ static ssize_t show_temp_max(struct devi
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr]));
 }

-static ssize_t show_temp_max_hyst(struct device *dev,
+static ssize_t temp_max_hyst_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -612,8 +615,9 @@ static ssize_t show_temp_max_hyst(struct
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max_hyst[nr]));
 }

-static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t temp_max_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -633,8 +637,9 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }

-static ssize_t set_temp_max_hyst(struct device *dev,
-	struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t temp_max_hyst_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -669,58 +674,42 @@ show_fan(fan_min);
 show_fan(fan_max);
 show_fan(fan_target);

-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
-static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO|S_IWUSR,
-	show_in_max, set_in_max, 0);
-static SENSOR_DEVICE_ATTR(in0_min, S_IRUGO|S_IWUSR,
-	show_in_min, set_in_min, 0);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
-static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO|S_IWUSR,
-	show_in_max, set_in_max, 1);
-static SENSOR_DEVICE_ATTR(in1_min, S_IRUGO|S_IWUSR,
-	show_in_min, set_in_min, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
-static SENSOR_DEVICE_ATTR(in2_max, S_IRUGO|S_IWUSR,
-	show_in_max, set_in_max, 2);
-static SENSOR_DEVICE_ATTR(in2_min, S_IRUGO|S_IWUSR,
-	show_in_min, set_in_min, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
-static SENSOR_DEVICE_ATTR(in3_max, S_IRUGO|S_IWUSR,
-	show_in_max, set_in_max, 3);
-static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO|S_IWUSR,
-	show_in_min, set_in_min, 3);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp11, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO|S_IWUSR,
-	show_temp_max_hyst, set_temp_max_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO|S_IWUSR,
-	show_temp_max, set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO|S_IWUSR,
-	show_temp_max_hyst, set_temp_max_hyst, 1);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO|S_IWUSR,
-	show_temp_max, set_temp_max, 1);
+static SENSOR_DEVICE_ATTR_RO(in0_input, in, 0);
+static SENSOR_DEVICE_ATTR_RW(in0_max, in_max, 0);
+static SENSOR_DEVICE_ATTR_RW(in0_min, in_min, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_input, in, 1);
+static SENSOR_DEVICE_ATTR_RW(in1_max, in_max, 1);
+static SENSOR_DEVICE_ATTR_RW(in1_min, in_min, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, in, 2);
+static SENSOR_DEVICE_ATTR_RW(in2_max, in_max, 2);
+static SENSOR_DEVICE_ATTR_RW(in2_min, in_min, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, in, 3);
+static SENSOR_DEVICE_ATTR_RW(in3_max, in_max, 3);
+static SENSOR_DEVICE_ATTR_RW(in3_min, in_min, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp11, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp_max_hyst, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp11, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max_hyst, temp_max_hyst, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
 static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
 static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO, show_fan_max, NULL, 0);
 static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO|S_IWUSR,
-	show_fan_min, set_fan_min, 0);
+	show_fan_min, fan_min_store, 0);
 static SENSOR_DEVICE_ATTR(fan1_target, S_IRUGO|S_IWUSR,
-	show_fan_target, set_fan_target, 0);
+	show_fan_target, fan_target_store, 0);
 static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
 static SENSOR_DEVICE_ATTR(fan2_max, S_IRUGO, show_fan_max, NULL, 1);
 static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO|S_IWUSR,
-	show_fan_min, set_fan_min, 1);
+	show_fan_min, fan_min_store, 1);
 static SENSOR_DEVICE_ATTR(fan2_target, S_IRUGO|S_IWUSR,
-	show_fan_target, set_fan_target, 1);
-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO|S_IWUSR,
-	show_pwm, set_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO|S_IWUSR,
-	show_pwm_enable, set_pwm_enable, 0);
+	show_fan_target, fan_target_store, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_enable, 0);
 static SENSOR_DEVICE_ATTR(pwm1_mode, S_IRUGO,
 	show_pwm_mode, set_pwm_mode, 0);
-static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR,
-	show_pwm, set_pwm, 1);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IRUGO|S_IWUSR,
-	show_pwm_enable, set_pwm_enable, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_enable, 1);
 static SENSOR_DEVICE_ATTR(pwm2_mode, S_IRUGO,
 	show_pwm_mode, set_pwm_mode, 1);

diff -u -p a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -653,28 +653,28 @@ static ssize_t set_aout(struct device *d
 }
 static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 14);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 15);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 14);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 15);

 /*
  * Real code
diff -u -p a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -263,7 +263,7 @@ show(RAW, alarms, alarms);
 show(BOOL, beep_enable, beep_enable);
 show(BEEP_MASK, beep_mask, beep_mask);

-static ssize_t show_fan_input(struct device *dev,
+static ssize_t fan_input_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -272,7 +272,7 @@ static ssize_t show_fan_input(struct dev
 					DIV_FROM_REG(data->fan_div[nr])));
 }

-static ssize_t show_fan_min(struct device *dev,
+static ssize_t fan_min_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -281,7 +281,7 @@ static ssize_t show_fan_min(struct devic
 					DIV_FROM_REG(data->fan_div[nr])));
 }

-static ssize_t show_fan_div(struct device *dev,
+static ssize_t fan_div_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -349,8 +349,9 @@ set_high(IN, in_max3, voltage_max[3], GL
 set_bits(BOOL, beep_enable, beep_enable, GL518_REG_CONF, 0x04, 2);
 set(BEEP_MASK, beep_mask, beep_mask, GL518_REG_ALARM);

-static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t fan_min_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct gl518_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -382,8 +383,9 @@ static ssize_t set_fan_min(struct device
 	return count;
 }

-static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t fan_div_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct gl518_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -431,16 +433,12 @@ static DEVICE_ATTR(temp1_max, S_IWUSR|S_
 static DEVICE_ATTR(temp1_max_hyst, S_IWUSR|S_IRUGO,
 	show_temp_hyst1, set_temp_hyst1);
 static DEVICE_ATTR(fan1_auto, S_IWUSR|S_IRUGO, show_fan_auto1, set_fan_auto1);
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR|S_IRUGO,
-	show_fan_min, set_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR|S_IRUGO,
-	show_fan_min, set_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan1_div, S_IWUSR|S_IRUGO,
-	show_fan_div, set_fan_div, 0);
-static SENSOR_DEVICE_ATTR(fan2_div, S_IWUSR|S_IRUGO,
-	show_fan_div, set_fan_div, 1);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1);
+static SENSOR_DEVICE_ATTR_RW(fan1_min, fan_min, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_min, fan_min, 1);
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 1);
 static DEVICE_ATTR(in0_input, S_IRUGO, show_in_input0, NULL);
 static DEVICE_ATTR(in1_input, S_IRUGO, show_in_input1, NULL);
 static DEVICE_ATTR(in2_input, S_IRUGO, show_in_input2, NULL);
@@ -459,7 +457,7 @@ static DEVICE_ATTR(beep_enable, S_IWUSR|
 static DEVICE_ATTR(beep_mask, S_IWUSR|S_IRUGO,
 	show_beep_mask, set_beep_mask);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
@@ -467,15 +465,15 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 6);

-static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
+static ssize_t beep_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
@@ -483,8 +481,8 @@ static ssize_t show_beep(struct device *
 	return sprintf(buf, "%u\n", (data->beep_mask >> bitnr) & 1);
 }

-static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t beep_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct gl518_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -510,13 +508,13 @@ static ssize_t set_beep(struct device *d
 	return count;
 }

-static SENSOR_DEVICE_ATTR(in0_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 0);
-static SENSOR_DEVICE_ATTR(in1_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 1);
-static SENSOR_DEVICE_ATTR(in2_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 2);
-static SENSOR_DEVICE_ATTR(in3_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 3);
-static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 4);
-static SENSOR_DEVICE_ATTR(fan1_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 5);
-static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO|S_IWUSR, show_beep, set_beep, 6);
+static SENSOR_DEVICE_ATTR_RW(in0_beep, beep, 0);
+static SENSOR_DEVICE_ATTR_RW(in1_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RW(in2_beep, beep, 2);
+static SENSOR_DEVICE_ATTR_RW(in3_beep, beep, 3);
+static SENSOR_DEVICE_ATTR_RW(temp1_beep, beep, 4);
+static SENSOR_DEVICE_ATTR_RW(fan1_beep, beep, 5);
+static SENSOR_DEVICE_ATTR_RW(fan2_beep, beep, 6);

 static struct attribute *gl518_attributes[] = {
 	&dev_attr_in3_input.attr,
diff -u -p a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -353,7 +353,7 @@ w83792d_write_value(struct i2c_client *c
 }

 /* following are the sysfs callback functions */
-static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+static ssize_t in_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -419,7 +419,7 @@ show_fan_reg(fan);
 show_fan_reg(fan_min);

 static ssize_t
-store_fan_min(struct device *dev, struct device_attribute *attr,
+fan_min_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -443,7 +443,7 @@ store_fan_min(struct device *dev, struct
 }

 static ssize_t
-show_fan_div(struct device *dev, struct device_attribute *attr,
+fan_div_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -459,7 +459,7 @@ show_fan_div(struct device *dev, struct
  * because the divisor changed.
  */
 static ssize_t
-store_fan_div(struct device *dev, struct device_attribute *attr,
+fan_div_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -501,7 +501,7 @@ store_fan_div(struct device *dev, struct

 /* read/write the temperature1, includes measured value and limits */

-static ssize_t show_temp1(struct device *dev, struct device_attribute *attr,
+static ssize_t temp1_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -510,7 +510,7 @@ static ssize_t show_temp1(struct device
 	return sprintf(buf, "%d\n", TEMP1_FROM_REG(data->temp1[nr]));
 }

-static ssize_t store_temp1(struct device *dev, struct device_attribute *attr,
+static ssize_t temp1_store(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -535,7 +535,7 @@ static ssize_t store_temp1(struct device

 /* read/write the temperature2-3, includes measured value and limits */

-static ssize_t show_temp23(struct device *dev, struct device_attribute *attr,
+static ssize_t temp23_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	struct sensor_device_attribute_2 *sensor_attr
@@ -548,7 +548,7 @@ static ssize_t show_temp23(struct device
 			data->temp_add[nr][index+1]));
 }

-static ssize_t store_temp23(struct device *dev, struct device_attribute *attr,
+static ssize_t temp23_store(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sensor_attr
@@ -584,7 +584,7 @@ show_alarms_reg(struct device *dev, stru
 	return sprintf(buf, "%d\n", data->alarms);
 }

-static ssize_t show_alarm(struct device *dev,
+static ssize_t alarm_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -594,7 +594,7 @@ static ssize_t show_alarm(struct device
 }

 static ssize_t
-show_pwm(struct device *dev, struct device_attribute *attr,
+pwm_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -604,7 +604,7 @@ show_pwm(struct device *dev, struct devi
 }

 static ssize_t
-show_pwmenable(struct device *dev, struct device_attribute *attr,
+pwmenable_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -628,7 +628,7 @@ show_pwmenable(struct device *dev, struc
 }

 static ssize_t
-store_pwm(struct device *dev, struct device_attribute *attr,
+pwm_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -653,7 +653,7 @@ store_pwm(struct device *dev, struct dev
 }

 static ssize_t
-store_pwmenable(struct device *dev, struct device_attribute *attr,
+pwmenable_store(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -695,7 +695,7 @@ store_pwmenable(struct device *dev, stru
 }

 static ssize_t
-show_pwm_mode(struct device *dev, struct device_attribute *attr,
+pwm_mode_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -705,7 +705,7 @@ show_pwm_mode(struct device *dev, struct
 }

 static ssize_t
-store_pwm_mode(struct device *dev, struct device_attribute *attr,
+pwm_mode_store(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -765,7 +765,7 @@ store_chassis_clear(struct device *dev,

 /* For Smart Fan I / Thermal Cruise */
 static ssize_t
-show_thermal_cruise(struct device *dev, struct device_attribute *attr,
+thermal_cruise_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -775,7 +775,7 @@ show_thermal_cruise(struct device *dev,
 }

 static ssize_t
-store_thermal_cruise(struct device *dev, struct device_attribute *attr,
+thermal_cruise_store(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -805,7 +805,7 @@ store_thermal_cruise(struct device *dev,

 /* For Smart Fan I/Thermal Cruise and Smart Fan II */
 static ssize_t
-show_tolerance(struct device *dev, struct device_attribute *attr,
+tolerance_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -815,7 +815,7 @@ show_tolerance(struct device *dev, struc
 }

 static ssize_t
-store_tolerance(struct device *dev, struct device_attribute *attr,
+tolerance_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -847,7 +847,7 @@ store_tolerance(struct device *dev, stru

 /* For Smart Fan II */
 static ssize_t
-show_sf2_point(struct device *dev, struct device_attribute *attr,
+sf2_point_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct sensor_device_attribute_2 *sensor_attr
@@ -859,7 +859,7 @@ show_sf2_point(struct device *dev, struc
 }

 static ssize_t
-store_sf2_point(struct device *dev, struct device_attribute *attr,
+sf2_point_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sensor_attr
@@ -888,7 +888,7 @@ store_sf2_point(struct device *dev, stru
 }

 static ssize_t
-show_sf2_level(struct device *dev, struct device_attribute *attr,
+sf2_level_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct sensor_device_attribute_2 *sensor_attr
@@ -901,7 +901,7 @@ show_sf2_level(struct device *dev, struc
 }

 static ssize_t
-store_sf2_level(struct device *dev, struct device_attribute *attr,
+sf2_level_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sensor_attr
@@ -987,15 +987,15 @@ ERROR_SC_0:
 	return err;
 }

-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_in, NULL, 7);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, show_in, NULL, 8);
+static SENSOR_DEVICE_ATTR_RO(in0_input, in, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_input, in, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, in, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, in, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, in, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_input, in, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_input, in, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_input, in, 7);
+static SENSOR_DEVICE_ATTR_RO(in8_input, in, 8);
 static SENSOR_DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO,
 			show_in_min, store_in_min, 0);
 static SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO,
@@ -1032,124 +1032,81 @@ static SENSOR_DEVICE_ATTR(in7_max, S_IWU
 			show_in_max, store_in_max, 7);
 static SENSOR_DEVICE_ATTR(in8_max, S_IWUSR | S_IRUGO,
 			show_in_max, store_in_max, 8);
-static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp1, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp23, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp23, NULL, 1, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR,
-			show_temp1, store_temp1, 0, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp23,
-			store_temp23, 0, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp23,
-			store_temp23, 1, 2);
-static SENSOR_DEVICE_ATTR_2(temp1_max_hyst, S_IRUGO | S_IWUSR,
-			show_temp1, store_temp1, 0, 2);
-static SENSOR_DEVICE_ATTR_2(temp2_max_hyst, S_IRUGO | S_IWUSR,
-			show_temp23, store_temp23, 0, 4);
-static SENSOR_DEVICE_ATTR_2(temp3_max_hyst, S_IRUGO | S_IWUSR,
-			show_temp23, store_temp23, 1, 4);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp1, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp23, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp23, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp1, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp23, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp23, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max_hyst, temp1, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max_hyst, temp23, 0, 4);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max_hyst, temp23, 1, 4);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(fan7_alarm, S_IRUGO, show_alarm, NULL, 15);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 19);
-static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 20);
-static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 21);
-static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 22);
-static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL, 23);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(fan7_alarm, alarm, 15);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, alarm, 19);
+static SENSOR_DEVICE_ATTR_RO(in8_alarm, alarm, 20);
+static SENSOR_DEVICE_ATTR_RO(fan4_alarm, alarm, 21);
+static SENSOR_DEVICE_ATTR_RO(fan5_alarm, alarm, 22);
+static SENSOR_DEVICE_ATTR_RO(fan6_alarm, alarm, 23);
 static DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR,
 			show_chassis_clear, store_chassis_clear);
-static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1);
-static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2);
-static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3);
-static SENSOR_DEVICE_ATTR(pwm5, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 4);
-static SENSOR_DEVICE_ATTR(pwm6, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 5);
-static SENSOR_DEVICE_ATTR(pwm7, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 6);
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
-			show_pwmenable, store_pwmenable, 1);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO,
-			show_pwmenable, store_pwmenable, 2);
-static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO,
-			show_pwmenable, store_pwmenable, 3);
-static SENSOR_DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO,
-			show_pwm_mode, store_pwm_mode, 0);
-static SENSOR_DEVICE_ATTR(pwm2_mode, S_IWUSR | S_IRUGO,
-			show_pwm_mode, store_pwm_mode, 1);
-static SENSOR_DEVICE_ATTR(pwm3_mode, S_IWUSR | S_IRUGO,
-			show_pwm_mode, store_pwm_mode, 2);
-static SENSOR_DEVICE_ATTR(pwm4_mode, S_IWUSR | S_IRUGO,
-			show_pwm_mode, store_pwm_mode, 3);
-static SENSOR_DEVICE_ATTR(pwm5_mode, S_IWUSR | S_IRUGO,
-			show_pwm_mode, store_pwm_mode, 4);
-static SENSOR_DEVICE_ATTR(pwm6_mode, S_IWUSR | S_IRUGO,
-			show_pwm_mode, store_pwm_mode, 5);
-static SENSOR_DEVICE_ATTR(pwm7_mode, S_IWUSR | S_IRUGO,
-			show_pwm_mode, store_pwm_mode, 6);
-static SENSOR_DEVICE_ATTR(tolerance1, S_IWUSR | S_IRUGO,
-			show_tolerance, store_tolerance, 1);
-static SENSOR_DEVICE_ATTR(tolerance2, S_IWUSR | S_IRUGO,
-			show_tolerance, store_tolerance, 2);
-static SENSOR_DEVICE_ATTR(tolerance3, S_IWUSR | S_IRUGO,
-			show_tolerance, store_tolerance, 3);
-static SENSOR_DEVICE_ATTR(thermal_cruise1, S_IWUSR | S_IRUGO,
-			show_thermal_cruise, store_thermal_cruise, 1);
-static SENSOR_DEVICE_ATTR(thermal_cruise2, S_IWUSR | S_IRUGO,
-			show_thermal_cruise, store_thermal_cruise, 2);
-static SENSOR_DEVICE_ATTR(thermal_cruise3, S_IWUSR | S_IRUGO,
-			show_thermal_cruise, store_thermal_cruise, 3);
-static SENSOR_DEVICE_ATTR_2(sf2_point1_fan1, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 1, 1);
-static SENSOR_DEVICE_ATTR_2(sf2_point2_fan1, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 2, 1);
-static SENSOR_DEVICE_ATTR_2(sf2_point3_fan1, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 3, 1);
-static SENSOR_DEVICE_ATTR_2(sf2_point4_fan1, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 4, 1);
-static SENSOR_DEVICE_ATTR_2(sf2_point1_fan2, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 1, 2);
-static SENSOR_DEVICE_ATTR_2(sf2_point2_fan2, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 2, 2);
-static SENSOR_DEVICE_ATTR_2(sf2_point3_fan2, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 3, 2);
-static SENSOR_DEVICE_ATTR_2(sf2_point4_fan2, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 4, 2);
-static SENSOR_DEVICE_ATTR_2(sf2_point1_fan3, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 1, 3);
-static SENSOR_DEVICE_ATTR_2(sf2_point2_fan3, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 2, 3);
-static SENSOR_DEVICE_ATTR_2(sf2_point3_fan3, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 3, 3);
-static SENSOR_DEVICE_ATTR_2(sf2_point4_fan3, S_IRUGO | S_IWUSR,
-			show_sf2_point, store_sf2_point, 4, 3);
-static SENSOR_DEVICE_ATTR_2(sf2_level1_fan1, S_IRUGO | S_IWUSR,
-			show_sf2_level, store_sf2_level, 1, 1);
-static SENSOR_DEVICE_ATTR_2(sf2_level2_fan1, S_IRUGO | S_IWUSR,
-			show_sf2_level, store_sf2_level, 2, 1);
-static SENSOR_DEVICE_ATTR_2(sf2_level3_fan1, S_IRUGO | S_IWUSR,
-			show_sf2_level, store_sf2_level, 3, 1);
-static SENSOR_DEVICE_ATTR_2(sf2_level1_fan2, S_IRUGO | S_IWUSR,
-			show_sf2_level, store_sf2_level, 1, 2);
-static SENSOR_DEVICE_ATTR_2(sf2_level2_fan2, S_IRUGO | S_IWUSR,
-			show_sf2_level, store_sf2_level, 2, 2);
-static SENSOR_DEVICE_ATTR_2(sf2_level3_fan2, S_IRUGO | S_IWUSR,
-			show_sf2_level, store_sf2_level, 3, 2);
-static SENSOR_DEVICE_ATTR_2(sf2_level1_fan3, S_IRUGO | S_IWUSR,
-			show_sf2_level, store_sf2_level, 1, 3);
-static SENSOR_DEVICE_ATTR_2(sf2_level2_fan3, S_IRUGO | S_IWUSR,
-			show_sf2_level, store_sf2_level, 2, 3);
-static SENSOR_DEVICE_ATTR_2(sf2_level3_fan3, S_IRUGO | S_IWUSR,
-			show_sf2_level, store_sf2_level, 3, 3);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4, pwm, 3);
+static SENSOR_DEVICE_ATTR_RW(pwm5, pwm, 4);
+static SENSOR_DEVICE_ATTR_RW(pwm6, pwm, 5);
+static SENSOR_DEVICE_ATTR_RW(pwm7, pwm, 6);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwmenable, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwmenable, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwmenable, 3);
+static SENSOR_DEVICE_ATTR_RW(pwm1_mode, pwm_mode, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_mode, pwm_mode, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_mode, pwm_mode, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_mode, pwm_mode, 3);
+static SENSOR_DEVICE_ATTR_RW(pwm5_mode, pwm_mode, 4);
+static SENSOR_DEVICE_ATTR_RW(pwm6_mode, pwm_mode, 5);
+static SENSOR_DEVICE_ATTR_RW(pwm7_mode, pwm_mode, 6);
+static SENSOR_DEVICE_ATTR_RW(tolerance1, tolerance, 1);
+static SENSOR_DEVICE_ATTR_RW(tolerance2, tolerance, 2);
+static SENSOR_DEVICE_ATTR_RW(tolerance3, tolerance, 3);
+static SENSOR_DEVICE_ATTR_RW(thermal_cruise1, thermal_cruise, 1);
+static SENSOR_DEVICE_ATTR_RW(thermal_cruise2, thermal_cruise, 2);
+static SENSOR_DEVICE_ATTR_RW(thermal_cruise3, thermal_cruise, 3);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point1_fan1, sf2_point, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point2_fan1, sf2_point, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point3_fan1, sf2_point, 3, 1);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point4_fan1, sf2_point, 4, 1);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point1_fan2, sf2_point, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point2_fan2, sf2_point, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point3_fan2, sf2_point, 3, 2);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point4_fan2, sf2_point, 4, 2);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point1_fan3, sf2_point, 1, 3);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point2_fan3, sf2_point, 2, 3);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point3_fan3, sf2_point, 3, 3);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_point4_fan3, sf2_point, 4, 3);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_level1_fan1, sf2_level, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_level2_fan1, sf2_level, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_level3_fan1, sf2_level, 3, 1);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_level1_fan2, sf2_level, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_level2_fan2, sf2_level, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_level3_fan2, sf2_level, 3, 2);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_level1_fan3, sf2_level, 1, 3);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_level2_fan3, sf2_level, 2, 3);
+static SENSOR_DEVICE_ATTR_2_RW(sf2_level3_fan3, sf2_level, 3, 3);
 static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 1);
 static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 2);
 static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 3);
@@ -1158,33 +1115,26 @@ static SENSOR_DEVICE_ATTR(fan5_input, S_
 static SENSOR_DEVICE_ATTR(fan6_input, S_IRUGO, show_fan, NULL, 6);
 static SENSOR_DEVICE_ATTR(fan7_input, S_IRUGO, show_fan, NULL, 7);
 static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO,
-			show_fan_min, store_fan_min, 1);
+			show_fan_min, fan_min_store, 1);
 static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO,
-			show_fan_min, store_fan_min, 2);
+			show_fan_min, fan_min_store, 2);
 static SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO,
-			show_fan_min, store_fan_min, 3);
+			show_fan_min, fan_min_store, 3);
 static SENSOR_DEVICE_ATTR(fan4_min, S_IWUSR | S_IRUGO,
-			show_fan_min, store_fan_min, 4);
+			show_fan_min, fan_min_store, 4);
 static SENSOR_DEVICE_ATTR(fan5_min, S_IWUSR | S_IRUGO,
-			show_fan_min, store_fan_min, 5);
+			show_fan_min, fan_min_store, 5);
 static SENSOR_DEVICE_ATTR(fan6_min, S_IWUSR | S_IRUGO,
-			show_fan_min, store_fan_min, 6);
+			show_fan_min, fan_min_store, 6);
 static SENSOR_DEVICE_ATTR(fan7_min, S_IWUSR | S_IRUGO,
-			show_fan_min, store_fan_min, 7);
-static SENSOR_DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO,
-			show_fan_div, store_fan_div, 1);
-static SENSOR_DEVICE_ATTR(fan2_div, S_IWUSR | S_IRUGO,
-			show_fan_div, store_fan_div, 2);
-static SENSOR_DEVICE_ATTR(fan3_div, S_IWUSR | S_IRUGO,
-			show_fan_div, store_fan_div, 3);
-static SENSOR_DEVICE_ATTR(fan4_div, S_IWUSR | S_IRUGO,
-			show_fan_div, store_fan_div, 4);
-static SENSOR_DEVICE_ATTR(fan5_div, S_IWUSR | S_IRUGO,
-			show_fan_div, store_fan_div, 5);
-static SENSOR_DEVICE_ATTR(fan6_div, S_IWUSR | S_IRUGO,
-			show_fan_div, store_fan_div, 6);
-static SENSOR_DEVICE_ATTR(fan7_div, S_IWUSR | S_IRUGO,
-			show_fan_div, store_fan_div, 7);
+			show_fan_min, fan_min_store, 7);
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 1);
+static SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 2);
+static SENSOR_DEVICE_ATTR_RW(fan3_div, fan_div, 3);
+static SENSOR_DEVICE_ATTR_RW(fan4_div, fan_div, 4);
+static SENSOR_DEVICE_ATTR_RW(fan5_div, fan_div, 5);
+static SENSOR_DEVICE_ATTR_RW(fan6_div, fan_div, 6);
+static SENSOR_DEVICE_ATTR_RW(fan7_div, fan_div, 7);

 static struct attribute *w83792d_attributes_fan[4][7] = {
 	{
diff -u -p a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
--- a/drivers/hwmon/ltc4261.c
+++ b/drivers/hwmon/ltc4261.c
@@ -132,7 +132,7 @@ static int ltc4261_get_value(struct ltc4
 	return val;
 }

-static ssize_t ltc4261_show_value(struct device *dev,
+static ssize_t ltc4261_value_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -146,7 +146,7 @@ static ssize_t ltc4261_show_value(struct
 	return snprintf(buf, PAGE_SIZE, "%d\n", value);
 }

-static ssize_t ltc4261_show_bool(struct device *dev,
+static ssize_t ltc4261_bool_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -166,10 +166,8 @@ static ssize_t ltc4261_show_bool(struct
 /*
  * Input voltages.
  */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4261_show_value, NULL,
-			  LTC4261_ADIN_H);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4261_show_value, NULL,
-			  LTC4261_ADIN2_H);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ltc4261_value, LTC4261_ADIN_H);
+static SENSOR_DEVICE_ATTR_RO(in2_input, ltc4261_value, LTC4261_ADIN2_H);

 /*
  * Voltage alarms. The chip has only one set of voltage alarm status bits,
@@ -179,22 +177,16 @@ static SENSOR_DEVICE_ATTR(in2_input, S_I
  * To ensure that the alarm condition is reported to the user, report it
  * with both voltage sensors.
  */
-static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ltc4261_show_bool, NULL,
-			  FAULT_UV);
-static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ltc4261_show_bool, NULL,
-			  FAULT_OV);
-static SENSOR_DEVICE_ATTR(in2_min_alarm, S_IRUGO, ltc4261_show_bool, NULL,
-			  FAULT_UV);
-static SENSOR_DEVICE_ATTR(in2_max_alarm, S_IRUGO, ltc4261_show_bool, NULL,
-			  FAULT_OV);
+static SENSOR_DEVICE_ATTR_RO(in1_min_alarm, ltc4261_bool, FAULT_UV);
+static SENSOR_DEVICE_ATTR_RO(in1_max_alarm, ltc4261_bool, FAULT_OV);
+static SENSOR_DEVICE_ATTR_RO(in2_min_alarm, ltc4261_bool, FAULT_UV);
+static SENSOR_DEVICE_ATTR_RO(in2_max_alarm, ltc4261_bool, FAULT_OV);

 /* Currents (via sense resistor) */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4261_show_value, NULL,
-			  LTC4261_SENSE_H);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ltc4261_value, LTC4261_SENSE_H);

 /* Overcurrent alarm */
-static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc4261_show_bool, NULL,
-			  FAULT_OC);
+static SENSOR_DEVICE_ATTR_RO(curr1_max_alarm, ltc4261_bool, FAULT_OC);

 static struct attribute *ltc4261_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -113,7 +113,7 @@ static int ina3221_read_value(struct ina
 	return 0;
 }

-static ssize_t ina3221_show_bus_voltage(struct device *dev,
+static ssize_t ina3221_bus_voltage_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
@@ -131,7 +131,7 @@ static ssize_t ina3221_show_bus_voltage(
 	return snprintf(buf, PAGE_SIZE, "%d\n", voltage_mv);
 }

-static ssize_t ina3221_show_shunt_voltage(struct device *dev,
+static ssize_t ina3221_shunt_voltage_show(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
@@ -148,7 +148,7 @@ static ssize_t ina3221_show_shunt_voltag
 	return snprintf(buf, PAGE_SIZE, "%d\n", voltage_uv);
 }

-static ssize_t ina3221_show_current(struct device *dev,
+static ssize_t ina3221_current_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
@@ -168,9 +168,9 @@ static ssize_t ina3221_show_current(stru
 	return snprintf(buf, PAGE_SIZE, "%d\n", current_ma);
 }

-static ssize_t ina3221_set_current(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
+static ssize_t ina3221_current_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
@@ -203,7 +203,7 @@ static ssize_t ina3221_set_current(struc
 	return count;
 }

-static ssize_t ina3221_show_shunt(struct device *dev,
+static ssize_t ina3221_shunt_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
@@ -216,9 +216,9 @@ static ssize_t ina3221_show_shunt(struct
 	return snprintf(buf, PAGE_SIZE, "%d\n", resistance_uo);
 }

-static ssize_t ina3221_set_shunt(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t count)
+static ssize_t ina3221_shunt_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
@@ -237,7 +237,7 @@ static ssize_t ina3221_set_shunt(struct
 	return count;
 }

-static ssize_t ina3221_show_alert(struct device *dev,
+static ssize_t ina3221_alert_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
@@ -254,68 +254,44 @@ static ssize_t ina3221_show_alert(struct
 }

 /* bus voltage */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO,
-		ina3221_show_bus_voltage, NULL, INA3221_BUS1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO,
-		ina3221_show_bus_voltage, NULL, INA3221_BUS2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO,
-		ina3221_show_bus_voltage, NULL, INA3221_BUS3);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ina3221_bus_voltage, INA3221_BUS1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, ina3221_bus_voltage, INA3221_BUS2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, ina3221_bus_voltage, INA3221_BUS3);

 /* calculated current */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO,
-		ina3221_show_current, NULL, INA3221_SHUNT1);
-static SENSOR_DEVICE_ATTR(curr2_input, S_IRUGO,
-		ina3221_show_current, NULL, INA3221_SHUNT2);
-static SENSOR_DEVICE_ATTR(curr3_input, S_IRUGO,
-		ina3221_show_current, NULL, INA3221_SHUNT3);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ina3221_current, INA3221_SHUNT1);
+static SENSOR_DEVICE_ATTR_RO(curr2_input, ina3221_current, INA3221_SHUNT2);
+static SENSOR_DEVICE_ATTR_RO(curr3_input, ina3221_current, INA3221_SHUNT3);

 /* shunt resistance */
-static SENSOR_DEVICE_ATTR(shunt1_resistor, S_IRUGO | S_IWUSR,
-		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL1);
-static SENSOR_DEVICE_ATTR(shunt2_resistor, S_IRUGO | S_IWUSR,
-		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL2);
-static SENSOR_DEVICE_ATTR(shunt3_resistor, S_IRUGO | S_IWUSR,
-		ina3221_show_shunt, ina3221_set_shunt, INA3221_CHANNEL3);
+static SENSOR_DEVICE_ATTR_RW(shunt1_resistor, ina3221_shunt, INA3221_CHANNEL1);
+static SENSOR_DEVICE_ATTR_RW(shunt2_resistor, ina3221_shunt, INA3221_CHANNEL2);
+static SENSOR_DEVICE_ATTR_RW(shunt3_resistor, ina3221_shunt, INA3221_CHANNEL3);

 /* critical current */
-static SENSOR_DEVICE_ATTR(curr1_crit, S_IRUGO | S_IWUSR,
-		ina3221_show_current, ina3221_set_current, INA3221_CRIT1);
-static SENSOR_DEVICE_ATTR(curr2_crit, S_IRUGO | S_IWUSR,
-		ina3221_show_current, ina3221_set_current, INA3221_CRIT2);
-static SENSOR_DEVICE_ATTR(curr3_crit, S_IRUGO | S_IWUSR,
-		ina3221_show_current, ina3221_set_current, INA3221_CRIT3);
+static SENSOR_DEVICE_ATTR_RW(curr1_crit, ina3221_current, INA3221_CRIT1);
+static SENSOR_DEVICE_ATTR_RW(curr2_crit, ina3221_current, INA3221_CRIT2);
+static SENSOR_DEVICE_ATTR_RW(curr3_crit, ina3221_current, INA3221_CRIT3);

 /* critical current alert */
-static SENSOR_DEVICE_ATTR(curr1_crit_alarm, S_IRUGO,
-		ina3221_show_alert, NULL, F_CF1);
-static SENSOR_DEVICE_ATTR(curr2_crit_alarm, S_IRUGO,
-		ina3221_show_alert, NULL, F_CF2);
-static SENSOR_DEVICE_ATTR(curr3_crit_alarm, S_IRUGO,
-		ina3221_show_alert, NULL, F_CF3);
+static SENSOR_DEVICE_ATTR_RO(curr1_crit_alarm, ina3221_alert, F_CF1);
+static SENSOR_DEVICE_ATTR_RO(curr2_crit_alarm, ina3221_alert, F_CF2);
+static SENSOR_DEVICE_ATTR_RO(curr3_crit_alarm, ina3221_alert, F_CF3);

 /* warning current */
-static SENSOR_DEVICE_ATTR(curr1_max, S_IRUGO | S_IWUSR,
-		ina3221_show_current, ina3221_set_current, INA3221_WARN1);
-static SENSOR_DEVICE_ATTR(curr2_max, S_IRUGO | S_IWUSR,
-		ina3221_show_current, ina3221_set_current, INA3221_WARN2);
-static SENSOR_DEVICE_ATTR(curr3_max, S_IRUGO | S_IWUSR,
-		ina3221_show_current, ina3221_set_current, INA3221_WARN3);
+static SENSOR_DEVICE_ATTR_RW(curr1_max, ina3221_current, INA3221_WARN1);
+static SENSOR_DEVICE_ATTR_RW(curr2_max, ina3221_current, INA3221_WARN2);
+static SENSOR_DEVICE_ATTR_RW(curr3_max, ina3221_current, INA3221_WARN3);

 /* warning current alert */
-static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO,
-		ina3221_show_alert, NULL, F_WF1);
-static SENSOR_DEVICE_ATTR(curr2_max_alarm, S_IRUGO,
-		ina3221_show_alert, NULL, F_WF2);
-static SENSOR_DEVICE_ATTR(curr3_max_alarm, S_IRUGO,
-		ina3221_show_alert, NULL, F_WF3);
+static SENSOR_DEVICE_ATTR_RO(curr1_max_alarm, ina3221_alert, F_WF1);
+static SENSOR_DEVICE_ATTR_RO(curr2_max_alarm, ina3221_alert, F_WF2);
+static SENSOR_DEVICE_ATTR_RO(curr3_max_alarm, ina3221_alert, F_WF3);

 /* shunt voltage */
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO,
-		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT1);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO,
-		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT2);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO,
-		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, ina3221_shunt_voltage, INA3221_SHUNT1);
+static SENSOR_DEVICE_ATTR_RO(in5_input, ina3221_shunt_voltage, INA3221_SHUNT2);
+static SENSOR_DEVICE_ATTR_RO(in6_input, ina3221_shunt_voltage, INA3221_SHUNT3);

 static struct attribute *ina3221_attrs[] = {
 	/* channel 1 */
diff -u -p a/drivers/hwmon/nsa320-hwmon.c b/drivers/hwmon/nsa320-hwmon.c
--- a/drivers/hwmon/nsa320-hwmon.c
+++ b/drivers/hwmon/nsa320-hwmon.c
@@ -114,7 +114,7 @@ static s32 nsa320_hwmon_update(struct de
 	return mcu_data;
 }

-static ssize_t show_label(struct device *dev,
+static ssize_t label_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	int channel = to_sensor_dev_attr(attr)->index;
@@ -144,9 +144,9 @@ static ssize_t show_fan(struct device *d
 	return sprintf(buf, "%d\n", ((mcu_data & 0xff0000) >> 16) * 100);
 }

-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL, NSA320_TEMP);
+static SENSOR_DEVICE_ATTR_RO(temp1_label, label, NSA320_TEMP);
 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
-static SENSOR_DEVICE_ATTR(fan1_label, S_IRUGO, show_label, NULL, NSA320_FAN);
+static SENSOR_DEVICE_ATTR_RO(fan1_label, label, NSA320_FAN);
 static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL);

 static struct attribute *nsa320_attrs[] = {
diff -u -p a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -830,7 +830,7 @@ static struct it87_data *it87_update_dev
 	return data;
 }

-static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+static ssize_t in_show(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -841,8 +841,8 @@ static ssize_t show_in(struct device *de
 	return sprintf(buf, "%d\n", in_from_reg(data, nr, data->in[nr][index]));
 }

-static ssize_t set_in(struct device *dev, struct device_attribute *attr,
-		      const char *buf, size_t count)
+static ssize_t in_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	struct it87_data *data = dev_get_drvdata(dev);
@@ -863,62 +863,46 @@ static ssize_t set_in(struct device *dev
 	return count;
 }

-static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(in0_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    0, 1);
-static SENSOR_DEVICE_ATTR_2(in0_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    0, 2);
-
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 1, 0);
-static SENSOR_DEVICE_ATTR_2(in1_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    1, 1);
-static SENSOR_DEVICE_ATTR_2(in1_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    1, 2);
-
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 2, 0);
-static SENSOR_DEVICE_ATTR_2(in2_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    2, 1);
-static SENSOR_DEVICE_ATTR_2(in2_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    2, 2);
-
-static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 3, 0);
-static SENSOR_DEVICE_ATTR_2(in3_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    3, 1);
-static SENSOR_DEVICE_ATTR_2(in3_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    3, 2);
-
-static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 4, 0);
-static SENSOR_DEVICE_ATTR_2(in4_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    4, 1);
-static SENSOR_DEVICE_ATTR_2(in4_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    4, 2);
-
-static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_in, NULL, 5, 0);
-static SENSOR_DEVICE_ATTR_2(in5_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    5, 1);
-static SENSOR_DEVICE_ATTR_2(in5_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    5, 2);
-
-static SENSOR_DEVICE_ATTR_2(in6_input, S_IRUGO, show_in, NULL, 6, 0);
-static SENSOR_DEVICE_ATTR_2(in6_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    6, 1);
-static SENSOR_DEVICE_ATTR_2(in6_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    6, 2);
-
-static SENSOR_DEVICE_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 7, 0);
-static SENSOR_DEVICE_ATTR_2(in7_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    7, 1);
-static SENSOR_DEVICE_ATTR_2(in7_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    7, 2);
-
-static SENSOR_DEVICE_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 8, 0);
-static SENSOR_DEVICE_ATTR_2(in9_input, S_IRUGO, show_in, NULL, 9, 0);
-static SENSOR_DEVICE_ATTR_2(in10_input, S_IRUGO, show_in, NULL, 10, 0);
-static SENSOR_DEVICE_ATTR_2(in11_input, S_IRUGO, show_in, NULL, 11, 0);
-static SENSOR_DEVICE_ATTR_2(in12_input, S_IRUGO, show_in, NULL, 12, 0);
+static SENSOR_DEVICE_ATTR_2_RO(in0_input, in, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in0_min, in, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in0_max, in, 0, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in1_input, in, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in1_min, in, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in1_max, in, 1, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in2_input, in, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in2_min, in, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in2_max, in, 2, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in3_input, in, 3, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in3_min, in, 3, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in3_max, in, 3, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in4_input, in, 4, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in4_min, in, 4, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in4_max, in, 4, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in5_input, in, 5, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in5_min, in, 5, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in5_max, in, 5, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in6_input, in, 6, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in6_min, in, 6, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in6_max, in, 6, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in7_input, in, 7, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in7_min, in, 7, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in7_max, in, 7, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(in8_input, in, 8, 0);
+static SENSOR_DEVICE_ATTR_2_RO(in9_input, in, 9, 0);
+static SENSOR_DEVICE_ATTR_2_RO(in10_input, in, 10, 0);
+static SENSOR_DEVICE_ATTR_2_RO(in11_input, in, 11, 0);
+static SENSOR_DEVICE_ATTR_2_RO(in12_input, in, 12, 0);

 /* Up to 6 temperatures */
-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -929,8 +913,8 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr][index]));
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	int nr = sattr->nr;
@@ -969,32 +953,23 @@ static ssize_t set_temp(struct device *d
 	return count;
 }

-static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    0, 1);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    0, 2);
-static SENSOR_DEVICE_ATTR_2(temp1_offset, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, 0, 3);
-static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 1, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    1, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    1, 2);
-static SENSOR_DEVICE_ATTR_2(temp2_offset, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, 1, 3);
-static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 2, 0);
-static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    2, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    2, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_offset, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, 2, 3);
-static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 3, 0);
-static SENSOR_DEVICE_ATTR_2(temp5_input, S_IRUGO, show_temp, NULL, 4, 0);
-static SENSOR_DEVICE_ATTR_2(temp6_input, S_IRUGO, show_temp, NULL, 5, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_min, temp, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_offset, temp, 0, 3);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_min, temp, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_offset, temp, 1, 3);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_min, temp, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_offset, temp, 2, 3);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_input, temp, 3, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp5_input, temp, 4, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp6_input, temp, 5, 0);

-static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_type_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -1013,8 +988,9 @@ static ssize_t show_temp_type(struct dev
 	return sprintf(buf, "0\n");      /* disabled */
 }

-static ssize_t set_temp_type(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t temp_type_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	int nr = sensor_attr->index;
@@ -1062,12 +1038,9 @@ static ssize_t set_temp_type(struct devi
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR, show_temp_type,
-			  set_temp_type, 0);
-static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR, show_temp_type,
-			  set_temp_type, 1);
-static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR, show_temp_type,
-			  set_temp_type, 2);
+static SENSOR_DEVICE_ATTR_RW(temp1_type, temp_type, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_type, temp_type, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_type, temp_type, 2);

 /* 6 Fans */

@@ -1084,7 +1057,7 @@ static int pwm_mode(const struct it87_da
 	return 1;				/* Manual mode */
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -1100,7 +1073,7 @@ static ssize_t show_fan(struct device *d
 	return sprintf(buf, "%d\n", speed);
 }

-static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_div_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -1110,7 +1083,7 @@ static ssize_t show_fan_div(struct devic
 	return sprintf(buf, "%lu\n", DIV_FROM_REG(data->fan_div[nr]));
 }

-static ssize_t show_pwm_enable(struct device *dev,
+static ssize_t pwm_enable_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -1120,7 +1093,7 @@ static ssize_t show_pwm_enable(struct de
 	return sprintf(buf, "%d\n", pwm_mode(data, nr));
 }

-static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -1131,7 +1104,7 @@ static ssize_t show_pwm(struct device *d
 		       pwm_from_reg(data, data->pwm_duty[nr]));
 }

-static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
+static ssize_t pwm_freq_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -1150,8 +1123,8 @@ static ssize_t show_pwm_freq(struct devi
 	return sprintf(buf, "%u\n", freq);
 }

-static ssize_t set_fan(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	int nr = sattr->nr;
@@ -1195,8 +1168,9 @@ static ssize_t set_fan(struct device *de
 	return count;
 }

-static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t fan_div_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	struct it87_data *data = dev_get_drvdata(dev);
@@ -1270,8 +1244,9 @@ static int check_trip_points(struct devi
 	return err;
 }

-static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr,
-			      const char *buf, size_t count)
+static ssize_t pwm_enable_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	struct it87_data *data = dev_get_drvdata(dev);
@@ -1332,8 +1307,8 @@ static ssize_t set_pwm_enable(struct dev
 	return count;
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	struct it87_data *data = dev_get_drvdata(dev);
@@ -1372,8 +1347,9 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }

-static ssize_t set_pwm_freq(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t pwm_freq_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
 	struct it87_data *data = dev_get_drvdata(dev);
@@ -1469,7 +1445,7 @@ static ssize_t set_pwm_temp_map(struct d
 	return count;
 }

-static ssize_t show_auto_pwm(struct device *dev, struct device_attribute *attr,
+static ssize_t auto_pwm_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
@@ -1482,8 +1458,9 @@ static ssize_t show_auto_pwm(struct devi
 		       pwm_from_reg(data, data->auto_pwm[nr][point]));
 }

-static ssize_t set_auto_pwm(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t auto_pwm_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *sensor_attr =
@@ -1507,7 +1484,7 @@ static ssize_t set_auto_pwm(struct devic
 	return count;
 }

-static ssize_t show_auto_pwm_slope(struct device *dev,
+static ssize_t auto_pwm_slope_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
@@ -1517,9 +1494,9 @@ static ssize_t show_auto_pwm_slope(struc
 	return sprintf(buf, "%d\n", data->auto_pwm[nr][1] & 0x7f);
 }

-static ssize_t set_auto_pwm_slope(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t auto_pwm_slope_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -1537,7 +1514,7 @@ static ssize_t set_auto_pwm_slope(struct
 	return count;
 }

-static ssize_t show_auto_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t auto_temp_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
@@ -1555,8 +1532,9 @@ static ssize_t show_auto_temp(struct dev
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(reg));
 }

-static ssize_t set_auto_temp(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t auto_temp_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *sensor_attr =
@@ -1586,180 +1564,114 @@ static ssize_t set_auto_temp(struct devi
 	return count;
 }

-static SENSOR_DEVICE_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(fan1_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    0, 1);
-static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR, show_fan_div,
-			  set_fan_div, 0);
-
-static SENSOR_DEVICE_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 1, 0);
-static SENSOR_DEVICE_ATTR_2(fan2_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    1, 1);
-static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR, show_fan_div,
-			  set_fan_div, 1);
-
-static SENSOR_DEVICE_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 2, 0);
-static SENSOR_DEVICE_ATTR_2(fan3_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    2, 1);
-static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO | S_IWUSR, show_fan_div,
-			  set_fan_div, 2);
-
-static SENSOR_DEVICE_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 3, 0);
-static SENSOR_DEVICE_ATTR_2(fan4_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    3, 1);
-
-static SENSOR_DEVICE_ATTR_2(fan5_input, S_IRUGO, show_fan, NULL, 4, 0);
-static SENSOR_DEVICE_ATTR_2(fan5_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    4, 1);
-
-static SENSOR_DEVICE_ATTR_2(fan6_input, S_IRUGO, show_fan, NULL, 5, 0);
-static SENSOR_DEVICE_ATTR_2(fan6_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    5, 1);
-
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
-			  show_pwm_enable, set_pwm_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm1_freq, S_IRUGO | S_IWUSR, show_pwm_freq,
-			  set_pwm_freq, 0);
+static SENSOR_DEVICE_ATTR_2_RO(fan1_input, fan, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(fan1_min, fan, 0, 1);
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(fan2_input, fan, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(fan2_min, fan, 1, 1);
+static SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 1);
+
+static SENSOR_DEVICE_ATTR_2_RO(fan3_input, fan, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(fan3_min, fan, 2, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_div, fan_div, 2);
+
+static SENSOR_DEVICE_ATTR_2_RO(fan4_input, fan, 3, 0);
+static SENSOR_DEVICE_ATTR_2_RW(fan4_min, fan, 3, 1);
+
+static SENSOR_DEVICE_ATTR_2_RO(fan5_input, fan, 4, 0);
+static SENSOR_DEVICE_ATTR_2_RW(fan5_min, fan, 4, 1);
+
+static SENSOR_DEVICE_ATTR_2_RO(fan6_input, fan, 5, 0);
+static SENSOR_DEVICE_ATTR_2_RW(fan6_min, fan, 5, 1);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_freq, pwm_freq, 0);
 static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 0, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_pwm, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 0, 1);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point3_pwm, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 0, 2);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point4_pwm, S_IRUGO,
-			    show_auto_pwm, NULL, 0, 3);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 0, 1);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 0, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 0, 2);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 0, 3);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point4_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 0, 4);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_start, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 0, 0);
-static SENSOR_DEVICE_ATTR(pwm1_auto_slope, S_IRUGO | S_IWUSR,
-			  show_auto_pwm_slope, set_auto_pwm_slope, 0);
-
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR,
-			  show_pwm_enable, set_pwm_enable, 1);
-static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 1);
-static SENSOR_DEVICE_ATTR(pwm2_freq, S_IRUGO, show_pwm_freq, set_pwm_freq, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_pwm, auto_pwm, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_pwm, auto_pwm, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_pwm, auto_pwm, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RO(pwm1_auto_point4_pwm, auto_pwm, 0, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_temp, auto_temp, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_temp_hyst, auto_temp, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_temp, auto_temp, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_temp, auto_temp, 0, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point4_temp, auto_temp, 0, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_start, auto_pwm, 0, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_slope, auto_pwm_slope, 0);
+
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_enable, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+static SENSOR_DEVICE_ATTR(pwm2_freq, S_IRUGO, pwm_freq_show, pwm_freq_store,
+			  1);
 static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 1, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_pwm, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 1, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point3_pwm, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 1, 2);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point4_pwm, S_IRUGO,
-			    show_auto_pwm, NULL, 1, 3);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 1, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 1, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 1, 2);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 1, 3);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point4_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 1, 4);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_start, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 1, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_slope, S_IRUGO | S_IWUSR,
-			  show_auto_pwm_slope, set_auto_pwm_slope, 1);
-
-static SENSOR_DEVICE_ATTR(pwm3_enable, S_IRUGO | S_IWUSR,
-			  show_pwm_enable, set_pwm_enable, 2);
-static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 2);
-static SENSOR_DEVICE_ATTR(pwm3_freq, S_IRUGO, show_pwm_freq, NULL, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_pwm, auto_pwm, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_pwm, auto_pwm, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point3_pwm, auto_pwm, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RO(pwm2_auto_point4_pwm, auto_pwm, 1, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_temp, auto_temp, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_temp_hyst, auto_temp, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_temp, auto_temp, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point3_temp, auto_temp, 1, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point4_temp, auto_temp, 1, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_start, auto_pwm, 1, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_slope, auto_pwm_slope, 1);
+
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwm_enable, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, 2);
+static SENSOR_DEVICE_ATTR_RO(pwm3_freq, pwm_freq, 2);
 static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point3_pwm, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 2, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point4_pwm, S_IRUGO,
-			    show_auto_pwm, NULL, 2, 3);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 3);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point4_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 4);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_start, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 2, 0);
-static SENSOR_DEVICE_ATTR(pwm3_auto_slope, S_IRUGO | S_IWUSR,
-			  show_auto_pwm_slope, set_auto_pwm_slope, 2);
-
-static SENSOR_DEVICE_ATTR(pwm4_enable, S_IRUGO | S_IWUSR,
-			  show_pwm_enable, set_pwm_enable, 3);
-static SENSOR_DEVICE_ATTR(pwm4, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 3);
-static SENSOR_DEVICE_ATTR(pwm4_freq, S_IRUGO, show_pwm_freq, NULL, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_pwm, auto_pwm, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_pwm, auto_pwm, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_pwm, auto_pwm, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RO(pwm3_auto_point4_pwm, auto_pwm, 2, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_temp, auto_temp, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_temp_hyst, auto_temp, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_temp, auto_temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_temp, auto_temp, 2, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point4_temp, auto_temp, 2, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_start, auto_pwm, 2, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_slope, auto_pwm_slope, 2);
+
+static SENSOR_DEVICE_ATTR_RW(pwm4_enable, pwm_enable, 3);
+static SENSOR_DEVICE_ATTR_RW(pwm4, pwm, 3);
+static SENSOR_DEVICE_ATTR_RO(pwm4_freq, pwm_freq, 3);
 static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 3);
-static SENSOR_DEVICE_ATTR_2(pwm4_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm4_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm4_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 2);
-static SENSOR_DEVICE_ATTR_2(pwm4_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 3);
-static SENSOR_DEVICE_ATTR_2(pwm4_auto_start, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 3, 0);
-static SENSOR_DEVICE_ATTR(pwm4_auto_slope, S_IRUGO | S_IWUSR,
-			  show_auto_pwm_slope, set_auto_pwm_slope, 3);
-
-static SENSOR_DEVICE_ATTR(pwm5_enable, S_IRUGO | S_IWUSR,
-			  show_pwm_enable, set_pwm_enable, 4);
-static SENSOR_DEVICE_ATTR(pwm5, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 4);
-static SENSOR_DEVICE_ATTR(pwm5_freq, S_IRUGO, show_pwm_freq, NULL, 4);
+static SENSOR_DEVICE_ATTR_2_RW(pwm4_auto_point1_temp, auto_temp, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm4_auto_point1_temp_hyst, auto_temp, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm4_auto_point2_temp, auto_temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm4_auto_point3_temp, auto_temp, 2, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm4_auto_start, auto_pwm, 3, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm4_auto_slope, auto_pwm_slope, 3);
+
+static SENSOR_DEVICE_ATTR_RW(pwm5_enable, pwm_enable, 4);
+static SENSOR_DEVICE_ATTR_RW(pwm5, pwm, 4);
+static SENSOR_DEVICE_ATTR_RO(pwm5_freq, pwm_freq, 4);
 static SENSOR_DEVICE_ATTR(pwm5_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 4);
-static SENSOR_DEVICE_ATTR_2(pwm5_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm5_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm5_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 2);
-static SENSOR_DEVICE_ATTR_2(pwm5_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 3);
-static SENSOR_DEVICE_ATTR_2(pwm5_auto_start, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 4, 0);
-static SENSOR_DEVICE_ATTR(pwm5_auto_slope, S_IRUGO | S_IWUSR,
-			  show_auto_pwm_slope, set_auto_pwm_slope, 4);
-
-static SENSOR_DEVICE_ATTR(pwm6_enable, S_IRUGO | S_IWUSR,
-			  show_pwm_enable, set_pwm_enable, 5);
-static SENSOR_DEVICE_ATTR(pwm6, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 5);
-static SENSOR_DEVICE_ATTR(pwm6_freq, S_IRUGO, show_pwm_freq, NULL, 5);
+static SENSOR_DEVICE_ATTR_2_RW(pwm5_auto_point1_temp, auto_temp, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm5_auto_point1_temp_hyst, auto_temp, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm5_auto_point2_temp, auto_temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm5_auto_point3_temp, auto_temp, 2, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm5_auto_start, auto_pwm, 4, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm5_auto_slope, auto_pwm_slope, 4);
+
+static SENSOR_DEVICE_ATTR_RW(pwm6_enable, pwm_enable, 5);
+static SENSOR_DEVICE_ATTR_RW(pwm6, pwm, 5);
+static SENSOR_DEVICE_ATTR_RO(pwm6_freq, pwm_freq, 5);
 static SENSOR_DEVICE_ATTR(pwm6_auto_channels_temp, S_IRUGO,
 			  show_pwm_temp_map, set_pwm_temp_map, 5);
-static SENSOR_DEVICE_ATTR_2(pwm6_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm6_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm6_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 2);
-static SENSOR_DEVICE_ATTR_2(pwm6_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_auto_temp, set_auto_temp, 2, 3);
-static SENSOR_DEVICE_ATTR_2(pwm6_auto_start, S_IRUGO | S_IWUSR,
-			    show_auto_pwm, set_auto_pwm, 5, 0);
-static SENSOR_DEVICE_ATTR(pwm6_auto_slope, S_IRUGO | S_IWUSR,
-			  show_auto_pwm_slope, set_auto_pwm_slope, 5);
+static SENSOR_DEVICE_ATTR_2_RW(pwm6_auto_point1_temp, auto_temp, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm6_auto_point1_temp_hyst, auto_temp, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm6_auto_point2_temp, auto_temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm6_auto_point3_temp, auto_temp, 2, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm6_auto_start, auto_pwm, 5, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm6_auto_slope, auto_pwm_slope, 5);

 /* Alarms */
 static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
@@ -1771,7 +1683,7 @@ static ssize_t show_alarms(struct device
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
@@ -1806,27 +1718,27 @@ static ssize_t clear_intrusion(struct de
 	return count;
 }

-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 14);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 15);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 16);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 17);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 18);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 13);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 14);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, alarm, 15);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(fan5_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan6_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 16);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 17);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 18);
 static SENSOR_DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR,
-			  show_alarm, clear_intrusion, 4);
+			  alarm_show, clear_intrusion, 4);

-static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
+static ssize_t beep_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);
@@ -1835,8 +1747,8 @@ static ssize_t show_beep(struct device *
 	return sprintf(buf, "%u\n", (data->beeps >> bitnr) & 1);
 }

-static ssize_t set_beep(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t beep_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct it87_data *data = dev_get_drvdata(dev);
@@ -1856,26 +1768,24 @@ static ssize_t set_beep(struct device *d
 	return count;
 }

-static SENSOR_DEVICE_ATTR(in0_beep, S_IRUGO | S_IWUSR,
-			  show_beep, set_beep, 1);
-static SENSOR_DEVICE_ATTR(in1_beep, S_IRUGO, show_beep, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_beep, S_IRUGO, show_beep, NULL, 1);
-static SENSOR_DEVICE_ATTR(in3_beep, S_IRUGO, show_beep, NULL, 1);
-static SENSOR_DEVICE_ATTR(in4_beep, S_IRUGO, show_beep, NULL, 1);
-static SENSOR_DEVICE_ATTR(in5_beep, S_IRUGO, show_beep, NULL, 1);
-static SENSOR_DEVICE_ATTR(in6_beep, S_IRUGO, show_beep, NULL, 1);
-static SENSOR_DEVICE_ATTR(in7_beep, S_IRUGO, show_beep, NULL, 1);
+static SENSOR_DEVICE_ATTR_RW(in0_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RO(in1_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RO(in3_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RO(in4_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RO(in5_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RO(in6_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RO(in7_beep, beep, 1);
 /* fanX_beep writability is set later */
-static SENSOR_DEVICE_ATTR(fan1_beep, S_IRUGO, show_beep, set_beep, 0);
-static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO, show_beep, set_beep, 0);
-static SENSOR_DEVICE_ATTR(fan3_beep, S_IRUGO, show_beep, set_beep, 0);
-static SENSOR_DEVICE_ATTR(fan4_beep, S_IRUGO, show_beep, set_beep, 0);
-static SENSOR_DEVICE_ATTR(fan5_beep, S_IRUGO, show_beep, set_beep, 0);
-static SENSOR_DEVICE_ATTR(fan6_beep, S_IRUGO, show_beep, set_beep, 0);
-static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO | S_IWUSR,
-			  show_beep, set_beep, 2);
-static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO, show_beep, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO, show_beep, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan1_beep, S_IRUGO, beep_show, beep_store, 0);
+static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO, beep_show, beep_store, 0);
+static SENSOR_DEVICE_ATTR(fan3_beep, S_IRUGO, beep_show, beep_store, 0);
+static SENSOR_DEVICE_ATTR(fan4_beep, S_IRUGO, beep_show, beep_store, 0);
+static SENSOR_DEVICE_ATTR(fan5_beep, S_IRUGO, beep_show, beep_store, 0);
+static SENSOR_DEVICE_ATTR(fan6_beep, S_IRUGO, beep_show, beep_store, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_beep, beep, 2);
+static SENSOR_DEVICE_ATTR_RO(temp2_beep, beep, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_beep, beep, 2);

 static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
 			    char *buf)
@@ -1909,7 +1819,7 @@ static ssize_t show_vid_reg(struct devic
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);

-static ssize_t show_label(struct device *dev, struct device_attribute *attr,
+static ssize_t label_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	static const char * const labels[] = {
@@ -1933,11 +1843,11 @@ static ssize_t show_label(struct device

 	return sprintf(buf, "%s\n", label);
 }
-static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL, 0);
-static SENSOR_DEVICE_ATTR(in7_label, S_IRUGO, show_label, NULL, 1);
-static SENSOR_DEVICE_ATTR(in8_label, S_IRUGO, show_label, NULL, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_label, label, 0);
+static SENSOR_DEVICE_ATTR_RO(in7_label, label, 1);
+static SENSOR_DEVICE_ATTR_RO(in8_label, label, 2);
 /* AVCC3 */
-static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, show_label, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(in9_label, label, 0);

 static umode_t it87_in_is_visible(struct kobject *kobj,
 				  struct attribute *attr, int index)
diff -u -p a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -331,7 +331,7 @@ get_fan_auto_nearest(struct adm1031_data
 	return -EINVAL;
 }

-static ssize_t show_fan_auto_channel(struct device *dev,
+static ssize_t fan_auto_channel_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -340,8 +340,8 @@ static ssize_t show_fan_auto_channel(str
 }

 static ssize_t
-set_fan_auto_channel(struct device *dev, struct device_attribute *attr,
-		     const char *buf, size_t count)
+fan_auto_channel_store(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
 {
 	struct adm1031_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -392,10 +392,8 @@ set_fan_auto_channel(struct device *dev,
 	return count;
 }

-static SENSOR_DEVICE_ATTR(auto_fan1_channel, S_IRUGO | S_IWUSR,
-		show_fan_auto_channel, set_fan_auto_channel, 0);
-static SENSOR_DEVICE_ATTR(auto_fan2_channel, S_IRUGO | S_IWUSR,
-		show_fan_auto_channel, set_fan_auto_channel, 1);
+static SENSOR_DEVICE_ATTR_RW(auto_fan1_channel, fan_auto_channel, 0);
+static SENSOR_DEVICE_ATTR_RW(auto_fan2_channel, fan_auto_channel, 1);

 /* Auto Temps */
 static ssize_t show_auto_temp_off(struct device *dev,
@@ -481,15 +479,15 @@ auto_temp_reg(2);
 auto_temp_reg(3);

 /* pwm */
-static ssize_t show_pwm(struct device *dev,
+static ssize_t pwm_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[nr]));
 }
-static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct adm1031_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -517,12 +515,10 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, set_pwm, 1);
-static SENSOR_DEVICE_ATTR(auto_fan1_min_pwm, S_IRUGO | S_IWUSR,
-		show_pwm, set_pwm, 0);
-static SENSOR_DEVICE_ATTR(auto_fan2_min_pwm, S_IRUGO | S_IWUSR,
-		show_pwm, set_pwm, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+static SENSOR_DEVICE_ATTR_RW(auto_fan1_min_pwm, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(auto_fan2_min_pwm, pwm, 1);

 /* Fans */

@@ -838,7 +834,7 @@ static ssize_t show_alarms(struct device

 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

-static ssize_t show_alarm(struct device *dev,
+static ssize_t alarm_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
@@ -846,21 +842,21 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%d\n", (data->alarm >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(fan2_fault, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 14);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(fan1_fault, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(fan2_fault, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(temp3_min_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_alarm, alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 13);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 14);

 /* Update Interval */
 static const unsigned int update_intervals[] = {
diff -u -p a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -269,7 +269,7 @@ done:
  * Sysfs stuff
  */

-static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+static ssize_t in_show(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
@@ -281,8 +281,8 @@ static ssize_t show_in(struct device *de
 	return sprintf(buf, "%d\n", IN_FROM_REG(data->in[nr][index]));
 }

-static ssize_t set_in(struct device *dev, struct device_attribute *attr,
-		      const char *buf, size_t count)
+static ssize_t in_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
 {
 	struct lm80_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -303,7 +303,7 @@ static ssize_t set_in(struct device *dev
 	return count;
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	int index = to_sensor_dev_attr_2(attr)->index;
@@ -315,7 +315,7 @@ static ssize_t show_fan(struct device *d
 		       DIV_FROM_REG(data->fan_div[index])));
 }

-static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_div_show(struct device *dev, struct device_attribute *attr,
 	char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -352,8 +352,9 @@ static ssize_t set_fan_min(struct device
  * least surprise; the user doesn't expect the fan minimum to change just
  * because the divisor changed.
  */
-static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
-	const char *buf, size_t count)
+static ssize_t fan_div_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm80_data *data = dev_get_drvdata(dev);
@@ -403,7 +404,7 @@ static ssize_t set_fan_div(struct device
 	return count;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -413,8 +414,9 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm80_data *data = dev_get_drvdata(dev);
@@ -441,7 +443,7 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%u\n", data->alarms);
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
@@ -451,72 +453,52 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR_2(in0_min, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_min, 0);
-static SENSOR_DEVICE_ATTR_2(in1_min, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_min, 1);
-static SENSOR_DEVICE_ATTR_2(in2_min, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_min, 2);
-static SENSOR_DEVICE_ATTR_2(in3_min, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_min, 3);
-static SENSOR_DEVICE_ATTR_2(in4_min, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_min, 4);
-static SENSOR_DEVICE_ATTR_2(in5_min, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_min, 5);
-static SENSOR_DEVICE_ATTR_2(in6_min, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_min, 6);
-static SENSOR_DEVICE_ATTR_2(in0_max, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_max, 0);
-static SENSOR_DEVICE_ATTR_2(in1_max, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_max, 1);
-static SENSOR_DEVICE_ATTR_2(in2_max, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_max, 2);
-static SENSOR_DEVICE_ATTR_2(in3_max, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_max, 3);
-static SENSOR_DEVICE_ATTR_2(in4_max, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_max, 4);
-static SENSOR_DEVICE_ATTR_2(in5_max, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_max, 5);
-static SENSOR_DEVICE_ATTR_2(in6_max, S_IWUSR | S_IRUGO,
-		show_in, set_in, i_max, 6);
-static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_in, NULL, i_input, 0);
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_in, NULL, i_input, 1);
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_in, NULL, i_input, 2);
-static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_in, NULL, i_input, 3);
-static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_in, NULL, i_input, 4);
-static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_in, NULL, i_input, 5);
-static SENSOR_DEVICE_ATTR_2(in6_input, S_IRUGO, show_in, NULL, i_input, 6);
+static SENSOR_DEVICE_ATTR_2_RW(in0_min, in, i_min, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in1_min, in, i_min, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in2_min, in, i_min, 2);
+static SENSOR_DEVICE_ATTR_2_RW(in3_min, in, i_min, 3);
+static SENSOR_DEVICE_ATTR_2_RW(in4_min, in, i_min, 4);
+static SENSOR_DEVICE_ATTR_2_RW(in5_min, in, i_min, 5);
+static SENSOR_DEVICE_ATTR_2_RW(in6_min, in, i_min, 6);
+static SENSOR_DEVICE_ATTR_2_RW(in0_max, in, i_max, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in1_max, in, i_max, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in2_max, in, i_max, 2);
+static SENSOR_DEVICE_ATTR_2_RW(in3_max, in, i_max, 3);
+static SENSOR_DEVICE_ATTR_2_RW(in4_max, in, i_max, 4);
+static SENSOR_DEVICE_ATTR_2_RW(in5_max, in, i_max, 5);
+static SENSOR_DEVICE_ATTR_2_RW(in6_max, in, i_max, 6);
+static SENSOR_DEVICE_ATTR_2_RO(in0_input, in, i_input, 0);
+static SENSOR_DEVICE_ATTR_2_RO(in1_input, in, i_input, 1);
+static SENSOR_DEVICE_ATTR_2_RO(in2_input, in, i_input, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in3_input, in, i_input, 3);
+static SENSOR_DEVICE_ATTR_2_RO(in4_input, in, i_input, 4);
+static SENSOR_DEVICE_ATTR_2_RO(in5_input, in, i_input, 5);
+static SENSOR_DEVICE_ATTR_2_RO(in6_input, in, i_input, 6);
 static SENSOR_DEVICE_ATTR_2(fan1_min, S_IWUSR | S_IRUGO,
-		show_fan, set_fan_min, f_min, 0);
+		fan_show, set_fan_min, f_min, 0);
 static SENSOR_DEVICE_ATTR_2(fan2_min, S_IWUSR | S_IRUGO,
-		show_fan, set_fan_min, f_min, 1);
-static SENSOR_DEVICE_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, f_input, 0);
-static SENSOR_DEVICE_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, f_input, 1);
-static SENSOR_DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO,
-		show_fan_div, set_fan_div, 0);
-static SENSOR_DEVICE_ATTR(fan2_div, S_IWUSR | S_IRUGO,
-		show_fan_div, set_fan_div, 1);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, t_input);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp,
-		set_temp, t_hot_max);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_temp,
-		set_temp, t_hot_hyst);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp,
-		set_temp, t_os_max);
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp,
-		set_temp, t_os_hyst);
+		fan_show, set_fan_min, f_min, 1);
+static SENSOR_DEVICE_ATTR_2_RO(fan1_input, fan, f_input, 0);
+static SENSOR_DEVICE_ATTR_2_RO(fan2_input, fan, f_input, 1);
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, t_input);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, t_hot_max);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp, t_hot_hyst);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp, t_os_max);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit_hyst, temp, t_os_hyst);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 13);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 13);

 /*
  * Real code
diff -u -p a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -309,7 +309,7 @@ abort:
 	return ret;
 }

-static ssize_t show_temp(struct device *dev,
+static ssize_t temp_show(struct device *dev,
 			 struct device_attribute *devattr, char *buf)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
@@ -323,7 +323,7 @@ static ssize_t show_temp(struct device *
 		tmp401_register_to_temp(data->temp[nr][index], data->config));
 }

-static ssize_t show_temp_crit_hyst(struct device *dev,
+static ssize_t temp_crit_hyst_show(struct device *dev,
 	struct device_attribute *devattr, char *buf)
 {
 	int temp, index = to_sensor_dev_attr(devattr)->index;
@@ -340,7 +340,7 @@ static ssize_t show_temp_crit_hyst(struc
 	return sprintf(buf, "%d\n", temp);
 }

-static ssize_t show_status(struct device *dev,
+static ssize_t status_show(struct device *dev,
 	struct device_attribute *devattr, char *buf)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
@@ -353,7 +353,7 @@ static ssize_t show_status(struct device
 	return sprintf(buf, "%d\n", !!(data->status[nr] & mask));
 }

-static ssize_t store_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_store(struct device *dev, struct device_attribute *devattr,
 			  const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
@@ -386,7 +386,7 @@ static ssize_t store_temp(struct device
 	return count;
 }

-static ssize_t store_temp_crit_hyst(struct device *dev, struct device_attribute
+static ssize_t temp_crit_hyst_store(struct device *dev, struct device_attribute
 	*devattr, const char *buf, size_t count)
 {
 	int temp, index = to_sensor_dev_attr(devattr)->index;
@@ -425,8 +425,9 @@ static ssize_t store_temp_crit_hyst(stru
  * This is done by writing any value to any of the minimum/maximum registers
  * (0x30-0x37).
  */
-static ssize_t reset_temp_history(struct device *dev,
-	struct device_attribute	*devattr, const char *buf, size_t count)
+static ssize_t retemp_history_store(struct device *dev,
+				    struct device_attribute *devattr,
+				    const char *buf, size_t count)
 {
 	struct tmp401_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -488,38 +489,29 @@ static ssize_t set_update_interval(struc
 	return count;
 }

-static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_min, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 1, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 2, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 3, 0);
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO,
-			  show_temp_crit_hyst, store_temp_crit_hyst, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_min_alarm, S_IRUGO, show_status, NULL,
-			    1, TMP432_STATUS_LOCAL);
-static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO, show_status, NULL,
-			    2, TMP432_STATUS_LOCAL);
-static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO, show_status, NULL,
-			    3, TMP432_STATUS_LOCAL);
-static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_min, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 1, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 2, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 3, 1);
-static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst,
-			  NULL, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_fault, S_IRUGO, show_status, NULL,
-			    0, TMP432_STATUS_REMOTE1);
-static SENSOR_DEVICE_ATTR_2(temp2_min_alarm, S_IRUGO, show_status, NULL,
-			    1, TMP432_STATUS_REMOTE1);
-static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO, show_status, NULL,
-			    2, TMP432_STATUS_REMOTE1);
-static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO, show_status, NULL,
-			    3, TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_min, temp, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 3, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit_hyst, temp_crit_hyst, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_min_alarm, status, 1,
+			       TMP432_STATUS_LOCAL);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_max_alarm, status, 2,
+			       TMP432_STATUS_LOCAL);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_crit_alarm, status, 3,
+			       TMP432_STATUS_LOCAL);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_min, temp, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_crit, temp, 3, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_hyst, temp_crit_hyst, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_fault, status, 0, TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_min_alarm, status, 1,
+			       TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_max_alarm, status, 2,
+			       TMP432_STATUS_REMOTE1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_crit_alarm, status, 3,
+			       TMP432_STATUS_REMOTE1);

 static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
 		   set_update_interval);
@@ -560,12 +552,11 @@ static const struct attribute_group tmp4
  * minimum and maximum register reset for both the local
  * and remote channels.
  */
-static SENSOR_DEVICE_ATTR_2(temp1_lowest, S_IRUGO, show_temp, NULL, 4, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_highest, S_IRUGO, show_temp, NULL, 5, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_lowest, S_IRUGO, show_temp, NULL, 4, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_highest, S_IRUGO, show_temp, NULL, 5, 1);
-static SENSOR_DEVICE_ATTR(temp_reset_history, S_IWUSR, NULL, reset_temp_history,
-			  0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_lowest, temp, 4, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_highest, temp, 5, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_lowest, temp, 4, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_highest, temp, 5, 1);
+static SENSOR_DEVICE_ATTR_WO(temp_reset_history, retemp_history, 0);

 static struct attribute *tmp411_attributes[] = {
 	&sensor_dev_attr_temp1_highest.dev_attr.attr,
@@ -580,23 +571,18 @@ static const struct attribute_group tmp4
 	.attrs = tmp411_attributes,
 };

-static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_min, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 1, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 2, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 3, 2);
-static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst,
-			  NULL, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_fault, S_IRUGO, show_status, NULL,
-			    0, TMP432_STATUS_REMOTE2);
-static SENSOR_DEVICE_ATTR_2(temp3_min_alarm, S_IRUGO, show_status, NULL,
-			    1, TMP432_STATUS_REMOTE2);
-static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO, show_status, NULL,
-			    2, TMP432_STATUS_REMOTE2);
-static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO, show_status, NULL,
-			    3, TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_min, temp, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_crit, temp, 3, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_hyst, temp_crit_hyst, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_fault, status, 0, TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_min_alarm, status, 1,
+			       TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_max_alarm, status, 2,
+			       TMP432_STATUS_REMOTE2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_crit_alarm, status, 3,
+			       TMP432_STATUS_REMOTE2);

 static struct attribute *tmp432_attributes[] = {
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
@@ -620,8 +606,7 @@ static const struct attribute_group tmp4
  * Additional features of the TMP461 chip.
  * The TMP461 temperature offset for the remote channel.
  */
-static SENSOR_DEVICE_ATTR_2(temp2_offset, S_IWUSR | S_IRUGO, show_temp,
-			    store_temp, 6, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_offset, temp, 6, 1);

 static struct attribute *tmp461_attributes[] = {
 	&sensor_dev_attr_temp2_offset.dev_attr.attr,
diff -u -p a/drivers/hwmon/ltc4260.c b/drivers/hwmon/ltc4260.c
--- a/drivers/hwmon/ltc4260.c
+++ b/drivers/hwmon/ltc4260.c
@@ -79,7 +79,7 @@ static int ltc4260_get_value(struct devi
 	return val;
 }

-static ssize_t ltc4260_show_value(struct device *dev,
+static ssize_t ltc4260_value_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -91,7 +91,7 @@ static ssize_t ltc4260_show_value(struct
 	return snprintf(buf, PAGE_SIZE, "%d\n", value);
 }

-static ssize_t ltc4260_show_bool(struct device *dev,
+static ssize_t ltc4260_bool_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -111,30 +111,24 @@ static ssize_t ltc4260_show_bool(struct
 }

 /* Voltages */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4260_show_value, NULL,
-			  LTC4260_SOURCE);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4260_show_value, NULL,
-			  LTC4260_ADIN);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ltc4260_value, LTC4260_SOURCE);
+static SENSOR_DEVICE_ATTR_RO(in2_input, ltc4260_value, LTC4260_ADIN);

 /*
  * Voltage alarms
  * UV/OV faults are associated with the input voltage, and the POWER BAD and
  * FET SHORT faults are associated with the output voltage.
  */
-static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ltc4260_show_bool, NULL,
-			  FAULT_UV);
-static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ltc4260_show_bool, NULL,
-			  FAULT_OV);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, ltc4260_show_bool, NULL,
-			  FAULT_POWER_BAD | FAULT_FET_SHORT);
+static SENSOR_DEVICE_ATTR_RO(in1_min_alarm, ltc4260_bool, FAULT_UV);
+static SENSOR_DEVICE_ATTR_RO(in1_max_alarm, ltc4260_bool, FAULT_OV);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, ltc4260_bool,
+			     FAULT_POWER_BAD | FAULT_FET_SHORT);

 /* Current (via sense resistor) */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4260_show_value, NULL,
-			  LTC4260_SENSE);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ltc4260_value, LTC4260_SENSE);

 /* Overcurrent alarm */
-static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc4260_show_bool, NULL,
-			  FAULT_OC);
+static SENSOR_DEVICE_ATTR_RO(curr1_max_alarm, ltc4260_bool, FAULT_OC);

 static struct attribute *ltc4260_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -162,7 +162,7 @@ abort:
 	return ret;
 }

-static ssize_t show_temp_input(struct device *dev,
+static ssize_t temp_input_show(struct device *dev,
 			       struct device_attribute *dev_attr, char *buf)
 {
 	long temp;
@@ -176,7 +176,7 @@ static ssize_t show_temp_input(struct de
 	return sprintf(buf, "%ld\n", temp);
 }

-static ssize_t show_temp_fault(struct device *dev,
+static ssize_t temp_fault_show(struct device *dev,
 			       struct device_attribute *dev_attr, char *buf)
 {
 	struct max6639_data *data = max6639_update_device(dev);
@@ -188,7 +188,7 @@ static ssize_t show_temp_fault(struct de
 	return sprintf(buf, "%d\n", data->temp_fault[attr->index]);
 }

-static ssize_t show_temp_max(struct device *dev,
+static ssize_t temp_max_show(struct device *dev,
 			     struct device_attribute *dev_attr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
@@ -197,9 +197,9 @@ static ssize_t show_temp_max(struct devi
 	return sprintf(buf, "%d\n", (data->temp_therm[attr->index] * 1000));
 }

-static ssize_t set_temp_max(struct device *dev,
-			    struct device_attribute *dev_attr,
-			    const char *buf, size_t count)
+static ssize_t temp_max_store(struct device *dev,
+			      struct device_attribute *dev_attr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
@@ -220,7 +220,7 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }

-static ssize_t show_temp_crit(struct device *dev,
+static ssize_t temp_crit_show(struct device *dev,
 			      struct device_attribute *dev_attr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
@@ -229,9 +229,9 @@ static ssize_t show_temp_crit(struct dev
 	return sprintf(buf, "%d\n", (data->temp_alert[attr->index] * 1000));
 }

-static ssize_t set_temp_crit(struct device *dev,
-			     struct device_attribute *dev_attr,
-			     const char *buf, size_t count)
+static ssize_t temp_crit_store(struct device *dev,
+			       struct device_attribute *dev_attr,
+			       const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
@@ -252,7 +252,7 @@ static ssize_t set_temp_crit(struct devi
 	return count;
 }

-static ssize_t show_temp_emergency(struct device *dev,
+static ssize_t temp_emergency_show(struct device *dev,
 				   struct device_attribute *dev_attr,
 				   char *buf)
 {
@@ -262,9 +262,9 @@ static ssize_t show_temp_emergency(struc
 	return sprintf(buf, "%d\n", (data->temp_ot[attr->index] * 1000));
 }

-static ssize_t set_temp_emergency(struct device *dev,
-				  struct device_attribute *dev_attr,
-				  const char *buf, size_t count)
+static ssize_t temp_emergency_store(struct device *dev,
+				    struct device_attribute *dev_attr,
+				    const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
@@ -285,7 +285,7 @@ static ssize_t set_temp_emergency(struct
 	return count;
 }

-static ssize_t show_pwm(struct device *dev,
+static ssize_t pwm_show(struct device *dev,
 			struct device_attribute *dev_attr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
@@ -294,9 +294,9 @@ static ssize_t show_pwm(struct device *d
 	return sprintf(buf, "%d\n", data->pwm[attr->index] * 255 / 120);
 }

-static ssize_t set_pwm(struct device *dev,
-		       struct device_attribute *dev_attr,
-		       const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev,
+			 struct device_attribute *dev_attr, const char *buf,
+			 size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
@@ -319,7 +319,7 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }

-static ssize_t show_fan_input(struct device *dev,
+static ssize_t fan_input_show(struct device *dev,
 			      struct device_attribute *dev_attr, char *buf)
 {
 	struct max6639_data *data = max6639_update_device(dev);
@@ -332,7 +332,7 @@ static ssize_t show_fan_input(struct dev
 		       data->rpm_range));
 }

-static ssize_t show_alarm(struct device *dev,
+static ssize_t alarm_show(struct device *dev,
 			  struct device_attribute *dev_attr, char *buf)
 {
 	struct max6639_data *data = max6639_update_device(dev);
@@ -344,34 +344,28 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%d\n", !!(data->status & (1 << attr->index)));
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
-		set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
-		set_temp_max, 1);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp_crit,
-		set_temp_crit, 0);
-static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_temp_crit,
-		set_temp_crit, 1);
-static SENSOR_DEVICE_ATTR(temp1_emergency, S_IWUSR | S_IRUGO,
-		show_temp_emergency, set_temp_emergency, 0);
-static SENSOR_DEVICE_ATTR(temp2_emergency, S_IWUSR | S_IRUGO,
-		show_temp_emergency, set_temp_emergency, 1);
-static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1);
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan2_fault, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp1_emergency_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp2_emergency_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_input, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_fault, temp_fault, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp_fault, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp_crit, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_crit, temp_crit, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_emergency, temp_emergency, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_emergency, temp_emergency, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1);
+static SENSOR_DEVICE_ATTR_RO(fan1_fault, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(fan2_fault, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp1_emergency_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp2_emergency_alarm, alarm, 4);


 static struct attribute *max6639_attrs[] = {
diff -u -p a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -234,7 +234,7 @@ static struct ds1621_data *ds1621_update
 	return data;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *da,
+static ssize_t temp_show(struct device *dev, struct device_attribute *da,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -243,8 +243,8 @@ static ssize_t show_temp(struct device *
 		       DS1621_TEMP_FROM_REG(data->temp[attr->index]));
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *da,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev, struct device_attribute *da,
+			  const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct ds1621_data *data = dev_get_drvdata(dev);
@@ -270,7 +270,7 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->conf));
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *da,
 			  char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -319,13 +319,11 @@ static DEVICE_ATTR(alarms, S_IRUGO, show
 static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_convrate,
 		   set_convrate);

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp, 1);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp, 2);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL,
-		DS1621_ALARM_TEMP_LOW);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
-		DS1621_ALARM_TEMP_HIGH);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, alarm, DS1621_ALARM_TEMP_LOW);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, DS1621_ALARM_TEMP_HIGH);

 static struct attribute *ds1621_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -677,7 +677,7 @@ static inline int sht15_calc_humid(struc
  * and heater_enable sysfs attributes.
  * Returns number of bytes written into buffer, negative errno on error.
  */
-static ssize_t sht15_show_status(struct device *dev,
+static ssize_t sht15_status_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
 {
@@ -734,7 +734,7 @@ static ssize_t sht15_store_heater(struct
  * Will be called on read access to temp1_input sysfs attribute.
  * Returns number of bytes written into buffer, negative errno on error.
  */
-static ssize_t sht15_show_temp(struct device *dev,
+static ssize_t sht15_temp_show(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
 {
@@ -757,7 +757,7 @@ static ssize_t sht15_show_temp(struct de
  * Will be called on read access to humidity1_input sysfs attribute.
  * Returns number of bytes written into buffer, negative errno on error.
  */
-static ssize_t sht15_show_humidity(struct device *dev,
+static ssize_t sht15_humidity_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
@@ -777,15 +777,13 @@ static ssize_t show_name(struct device *
 	return sprintf(buf, "%s\n", pdev->name);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
-			  sht15_show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO,
-			  sht15_show_humidity, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, sht15_show_status, NULL,
-			  SHT15_STATUS_LOW_BATTERY);
-static SENSOR_DEVICE_ATTR(humidity1_fault, S_IRUGO, sht15_show_status, NULL,
-			  SHT15_STATUS_LOW_BATTERY);
-static SENSOR_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR, sht15_show_status,
+static SENSOR_DEVICE_ATTR_RO(temp1_input, sht15_temp, 0);
+static SENSOR_DEVICE_ATTR_RO(humidity1_input, sht15_humidity, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_fault, sht15_status,
+			     SHT15_STATUS_LOW_BATTERY);
+static SENSOR_DEVICE_ATTR_RO(humidity1_fault, sht15_status,
+			     SHT15_STATUS_LOW_BATTERY);
+static SENSOR_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR, sht15_status_show,
 			  sht15_store_heater, SHT15_STATUS_HEATER);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static struct attribute *sht15_attrs[] = {
diff -u -p a/drivers/hwmon/tc654.c b/drivers/hwmon/tc654.c
--- a/drivers/hwmon/tc654.c
+++ b/drivers/hwmon/tc654.c
@@ -200,7 +200,7 @@ out:
  * sysfs attributes
  */

-static ssize_t show_fan(struct device *dev, struct device_attribute *da,
+static ssize_t fan_show(struct device *dev, struct device_attribute *da,
 			char *buf)
 {
 	int nr = to_sensor_dev_attr(da)->index;
@@ -218,7 +218,7 @@ static ssize_t show_fan(struct device *d
 	return sprintf(buf, "%d\n", val);
 }

-static ssize_t show_fan_min(struct device *dev, struct device_attribute *da,
+static ssize_t fan_min_show(struct device *dev, struct device_attribute *da,
 			    char *buf)
 {
 	int nr = to_sensor_dev_attr(da)->index;
@@ -231,8 +231,8 @@ static ssize_t show_fan_min(struct devic
 		       TC654_FAN_FAULT_FROM_REG(data->fan_fault[nr]));
 }

-static ssize_t set_fan_min(struct device *dev, struct device_attribute *da,
-			   const char *buf, size_t count)
+static ssize_t fan_min_store(struct device *dev, struct device_attribute *da,
+			     const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(da)->index;
 	struct tc654_data *data = dev_get_drvdata(dev);
@@ -255,7 +255,7 @@ static ssize_t set_fan_min(struct device
 	return ret < 0 ? ret : count;
 }

-static ssize_t show_fan_alarm(struct device *dev, struct device_attribute *da,
+static ssize_t fan_alarm_show(struct device *dev, struct device_attribute *da,
 			      char *buf)
 {
 	int nr = to_sensor_dev_attr(da)->index;
@@ -275,7 +275,7 @@ static ssize_t show_fan_alarm(struct dev

 static const u8 TC654_FAN_PULSE_SHIFT[] = { 1, 3 };

-static ssize_t show_fan_pulses(struct device *dev, struct device_attribute *da,
+static ssize_t fan_pulses_show(struct device *dev, struct device_attribute *da,
 			       char *buf)
 {
 	int nr = to_sensor_dev_attr(da)->index;
@@ -289,8 +289,9 @@ static ssize_t show_fan_pulses(struct de
 	return sprintf(buf, "%d\n", val);
 }

-static ssize_t set_fan_pulses(struct device *dev, struct device_attribute *da,
-			      const char *buf, size_t count)
+static ssize_t fan_pulses_store(struct device *dev,
+				struct device_attribute *da, const char *buf,
+				size_t count)
 {
 	int nr = to_sensor_dev_attr(da)->index;
 	struct tc654_data *data = dev_get_drvdata(dev);
@@ -329,7 +330,7 @@ static ssize_t set_fan_pulses(struct dev
 	return ret < 0 ? ret : count;
 }

-static ssize_t show_pwm_mode(struct device *dev,
+static ssize_t pwm_mode_show(struct device *dev,
 			     struct device_attribute *da, char *buf)
 {
 	struct tc654_data *data = tc654_update_client(dev);
@@ -340,9 +341,8 @@ static ssize_t show_pwm_mode(struct devi
 	return sprintf(buf, "%d\n", !!(data->config & TC654_REG_CONFIG_DUTYC));
 }

-static ssize_t set_pwm_mode(struct device *dev,
-			    struct device_attribute *da,
-			    const char *buf, size_t count)
+static ssize_t pwm_mode_store(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
 {
 	struct tc654_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -371,7 +371,7 @@ static ssize_t set_pwm_mode(struct devic
 static const int tc654_pwm_map[16] = { 77,  88, 102, 112, 124, 136, 148, 160,
 				      172, 184, 196, 207, 219, 231, 243, 255};

-static ssize_t show_pwm(struct device *dev, struct device_attribute *da,
+static ssize_t pwm_show(struct device *dev, struct device_attribute *da,
 			char *buf)
 {
 	struct tc654_data *data = tc654_update_client(dev);
@@ -388,8 +388,8 @@ static ssize_t show_pwm(struct device *d
 	return sprintf(buf, "%d\n", pwm);
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
-		       const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev, struct device_attribute *da,
+			 const char *buf, size_t count)
 {
 	struct tc654_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -423,22 +423,16 @@ out:
 	return ret < 0 ? ret : count;
 }

-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
-			  set_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
-			  set_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan1_pulses, S_IWUSR | S_IRUGO, show_fan_pulses,
-			  set_fan_pulses, 0);
-static SENSOR_DEVICE_ATTR(fan2_pulses, S_IWUSR | S_IRUGO, show_fan_pulses,
-			  set_fan_pulses, 1);
-static SENSOR_DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO,
-			  show_pwm_mode, set_pwm_mode, 0);
-static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm,
-			  set_pwm, 0);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 1);
+static SENSOR_DEVICE_ATTR_RW(fan1_min, fan_min, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_min, fan_min, 1);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, fan_alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, fan_alarm, 1);
+static SENSOR_DEVICE_ATTR_RW(fan1_pulses, fan_pulses, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_pulses, fan_pulses, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1_mode, pwm_mode, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);

 /* Driver data */
 static struct attribute *tc654_attrs[] = {
diff -u -p a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
--- a/drivers/hwmon/ds620.c
+++ b/drivers/hwmon/ds620.c
@@ -139,7 +139,7 @@ abort:
 	return ret;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *da,
+static ssize_t temp_show(struct device *dev, struct device_attribute *da,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -151,8 +151,8 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", ((data->temp[attr->index] / 8) * 625) / 10);
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *da,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev, struct device_attribute *da,
+			  const char *buf, size_t count)
 {
 	int res;
 	long val;
@@ -176,7 +176,7 @@ static ssize_t set_temp(struct device *d
 	return count;
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *da,
 			  char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -207,13 +207,11 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%d\n", !!(conf & attr->index));
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp, 1);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp, 2);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL,
-			  DS620_REG_CONFIG_TLF);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
-			  DS620_REG_CONFIG_THF);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, alarm, DS620_REG_CONFIG_TLF);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, DS620_REG_CONFIG_THF);

 static struct attribute *ds620_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/max1668.c b/drivers/hwmon/max1668.c
--- a/drivers/hwmon/max1668.c
+++ b/drivers/hwmon/max1668.c
@@ -140,7 +140,7 @@ abort:
 	return ret;
 }

-static ssize_t show_temp(struct device *dev,
+static ssize_t temp_show(struct device *dev,
 			 struct device_attribute *devattr, char *buf)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
@@ -176,7 +176,7 @@ static ssize_t show_temp_min(struct devi
 	return sprintf(buf, "%d\n", data->temp_min[index] * 1000);
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int index = to_sensor_dev_attr(attr)->index;
@@ -188,7 +188,7 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (data->alarms >> index) & 0x1);
 }

-static ssize_t show_fault(struct device *dev,
+static ssize_t fault_show(struct device *dev,
 			  struct device_attribute *devattr, char *buf)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
@@ -253,47 +253,47 @@ static ssize_t set_temp_min(struct devic
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_max,
 				set_temp_max, 0);
 static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO, show_temp_min,
 				set_temp_min, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
 static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_temp_max,
 				set_temp_max, 1);
 static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO, show_temp_min,
 				set_temp_min, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
 static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO, show_temp_max,
 				set_temp_max, 2);
 static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO, show_temp_min,
 				set_temp_min, 2);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 3);
 static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO, show_temp_max,
 				set_temp_max, 3);
 static SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO, show_temp_min,
 				set_temp_min, 3);
-static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4);
+static SENSOR_DEVICE_ATTR_RO(temp5_input, temp, 4);
 static SENSOR_DEVICE_ATTR(temp5_max, S_IRUGO, show_temp_max,
 				set_temp_max, 4);
 static SENSOR_DEVICE_ATTR(temp5_min, S_IRUGO, show_temp_min,
 				set_temp_min, 4);

-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 14);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp5_min_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_alarm, NULL, 0);
-
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_fault, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_fault, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_fault, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_fault, NULL, 4);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 14);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, alarm, 13);
+static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp3_min_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp4_min_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp5_min_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp5_max_alarm, alarm, 0);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, fault, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, fault, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_fault, fault, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_fault, fault, 4);

 /* Attributes common to MAX1668, MAX1989 and MAX1805 */
 static struct attribute *max1668_attribute_common[] = {
diff -u -p a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
--- a/drivers/hwmon/emc6w201.c
+++ b/drivers/hwmon/emc6w201.c
@@ -189,7 +189,7 @@ static struct emc6w201_data *emc6w201_up

 static const s16 nominal_mv[6] = { 2500, 1500, 3300, 5000, 1500, 1500 };

-static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
+static ssize_t in_show(struct device *dev, struct device_attribute *devattr,
 	char *buf)
 {
 	struct emc6w201_data *data = emc6w201_update_device(dev);
@@ -200,8 +200,8 @@ static ssize_t show_in(struct device *de
 		       (unsigned)data->in[sf][nr] * nominal_mv[nr] / 0xC0);
 }

-static ssize_t set_in(struct device *dev, struct device_attribute *devattr,
-		      const char *buf, size_t count)
+static ssize_t in_store(struct device *dev, struct device_attribute *devattr,
+			const char *buf, size_t count)
 {
 	struct emc6w201_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -228,7 +228,7 @@ static ssize_t set_in(struct device *dev
 	return err < 0 ? err : count;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 	char *buf)
 {
 	struct emc6w201_data *data = emc6w201_update_device(dev);
@@ -238,8 +238,9 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", (int)data->temp[sf][nr] * 1000);
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	struct emc6w201_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -266,7 +267,7 @@ static ssize_t set_temp(struct device *d
 	return err < 0 ? err : count;
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
+static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
 	char *buf)
 {
 	struct emc6w201_data *data = emc6w201_update_device(dev);
@@ -282,8 +283,8 @@ static ssize_t show_fan(struct device *d
 	return sprintf(buf, "%u\n", rpm);
 }

-static ssize_t set_fan(struct device *dev, struct device_attribute *devattr,
-		       const char *buf, size_t count)
+static ssize_t fan_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
 {
 	struct emc6w201_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -312,83 +313,54 @@ static ssize_t set_fan(struct device *de
 	return err < 0 ? err : count;
 }

-static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, input);
-static SENSOR_DEVICE_ATTR_2(in0_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    0, min);
-static SENSOR_DEVICE_ATTR_2(in0_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    0, max);
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 1, input);
-static SENSOR_DEVICE_ATTR_2(in1_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    1, min);
-static SENSOR_DEVICE_ATTR_2(in1_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    1, max);
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 2, input);
-static SENSOR_DEVICE_ATTR_2(in2_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    2, min);
-static SENSOR_DEVICE_ATTR_2(in2_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    2, max);
-static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 3, input);
-static SENSOR_DEVICE_ATTR_2(in3_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    3, min);
-static SENSOR_DEVICE_ATTR_2(in3_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    3, max);
-static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 4, input);
-static SENSOR_DEVICE_ATTR_2(in4_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    4, min);
-static SENSOR_DEVICE_ATTR_2(in4_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    4, max);
-static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_in, NULL, 5, input);
-static SENSOR_DEVICE_ATTR_2(in5_min, S_IRUGO | S_IWUSR, show_in, set_in,
-			    5, min);
-static SENSOR_DEVICE_ATTR_2(in5_max, S_IRUGO | S_IWUSR, show_in, set_in,
-			    5, max);
-
-static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, input);
-static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    0, min);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    0, max);
-static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 1, input);
-static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    1, min);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    1, max);
-static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 2, input);
-static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    2, min);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    2, max);
-static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 3, input);
-static SENSOR_DEVICE_ATTR_2(temp4_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    3, min);
-static SENSOR_DEVICE_ATTR_2(temp4_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    3, max);
-static SENSOR_DEVICE_ATTR_2(temp5_input, S_IRUGO, show_temp, NULL, 4, input);
-static SENSOR_DEVICE_ATTR_2(temp5_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    4, min);
-static SENSOR_DEVICE_ATTR_2(temp5_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    4, max);
-static SENSOR_DEVICE_ATTR_2(temp6_input, S_IRUGO, show_temp, NULL, 5, input);
-static SENSOR_DEVICE_ATTR_2(temp6_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    5, min);
-static SENSOR_DEVICE_ATTR_2(temp6_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    5, max);
-
-static SENSOR_DEVICE_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, input);
-static SENSOR_DEVICE_ATTR_2(fan1_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    0, min);
-static SENSOR_DEVICE_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 1, input);
-static SENSOR_DEVICE_ATTR_2(fan2_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    1, min);
-static SENSOR_DEVICE_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 2, input);
-static SENSOR_DEVICE_ATTR_2(fan3_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    2, min);
-static SENSOR_DEVICE_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 3, input);
-static SENSOR_DEVICE_ATTR_2(fan4_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    3, min);
-static SENSOR_DEVICE_ATTR_2(fan5_input, S_IRUGO, show_fan, NULL, 4, input);
-static SENSOR_DEVICE_ATTR_2(fan5_min, S_IRUGO | S_IWUSR, show_fan, set_fan,
-			    4, min);
+static SENSOR_DEVICE_ATTR_2_RO(in0_input, in, 0, input);
+static SENSOR_DEVICE_ATTR_2_RW(in0_min, in, 0, min);
+static SENSOR_DEVICE_ATTR_2_RW(in0_max, in, 0, max);
+static SENSOR_DEVICE_ATTR_2_RO(in1_input, in, 1, input);
+static SENSOR_DEVICE_ATTR_2_RW(in1_min, in, 1, min);
+static SENSOR_DEVICE_ATTR_2_RW(in1_max, in, 1, max);
+static SENSOR_DEVICE_ATTR_2_RO(in2_input, in, 2, input);
+static SENSOR_DEVICE_ATTR_2_RW(in2_min, in, 2, min);
+static SENSOR_DEVICE_ATTR_2_RW(in2_max, in, 2, max);
+static SENSOR_DEVICE_ATTR_2_RO(in3_input, in, 3, input);
+static SENSOR_DEVICE_ATTR_2_RW(in3_min, in, 3, min);
+static SENSOR_DEVICE_ATTR_2_RW(in3_max, in, 3, max);
+static SENSOR_DEVICE_ATTR_2_RO(in4_input, in, 4, input);
+static SENSOR_DEVICE_ATTR_2_RW(in4_min, in, 4, min);
+static SENSOR_DEVICE_ATTR_2_RW(in4_max, in, 4, max);
+static SENSOR_DEVICE_ATTR_2_RO(in5_input, in, 5, input);
+static SENSOR_DEVICE_ATTR_2_RW(in5_min, in, 5, min);
+static SENSOR_DEVICE_ATTR_2_RW(in5_max, in, 5, max);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0, input);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_min, temp, 0, min);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, max);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 1, input);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_min, temp, 1, min);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp, 1, max);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 2, input);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_min, temp, 2, min);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp, 2, max);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_input, temp, 3, input);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_min, temp, 3, min);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_max, temp, 3, max);
+static SENSOR_DEVICE_ATTR_2_RO(temp5_input, temp, 4, input);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_min, temp, 4, min);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_max, temp, 4, max);
+static SENSOR_DEVICE_ATTR_2_RO(temp6_input, temp, 5, input);
+static SENSOR_DEVICE_ATTR_2_RW(temp6_min, temp, 5, min);
+static SENSOR_DEVICE_ATTR_2_RW(temp6_max, temp, 5, max);
+
+static SENSOR_DEVICE_ATTR_2_RO(fan1_input, fan, 0, input);
+static SENSOR_DEVICE_ATTR_2_RW(fan1_min, fan, 0, min);
+static SENSOR_DEVICE_ATTR_2_RO(fan2_input, fan, 1, input);
+static SENSOR_DEVICE_ATTR_2_RW(fan2_min, fan, 1, min);
+static SENSOR_DEVICE_ATTR_2_RO(fan3_input, fan, 2, input);
+static SENSOR_DEVICE_ATTR_2_RW(fan3_min, fan, 2, min);
+static SENSOR_DEVICE_ATTR_2_RO(fan4_input, fan, 3, input);
+static SENSOR_DEVICE_ATTR_2_RW(fan4_min, fan, 3, min);
+static SENSOR_DEVICE_ATTR_2_RO(fan5_input, fan, 4, input);
+static SENSOR_DEVICE_ATTR_2_RW(fan5_min, fan, 4, min);

 static struct attribute *emc6w201_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -156,7 +156,7 @@ static struct adm1021_data *adm1021_upda
 	return data;
 }

-static ssize_t show_temp(struct device *dev,
+static ssize_t temp_show(struct device *dev,
 			 struct device_attribute *devattr, char *buf)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
@@ -165,7 +165,7 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", data->temp[index]);
 }

-static ssize_t show_temp_max(struct device *dev,
+static ssize_t temp_max_show(struct device *dev,
 			     struct device_attribute *devattr, char *buf)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
@@ -174,7 +174,7 @@ static ssize_t show_temp_max(struct devi
 	return sprintf(buf, "%d\n", data->temp_max[index]);
 }

-static ssize_t show_temp_min(struct device *dev,
+static ssize_t temp_min_show(struct device *dev,
 			     struct device_attribute *devattr, char *buf)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
@@ -183,7 +183,7 @@ static ssize_t show_temp_min(struct devi
 	return sprintf(buf, "%d\n", data->temp_min[index]);
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int index = to_sensor_dev_attr(attr)->index;
@@ -199,9 +199,9 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%u\n", data->alarms);
 }

-static ssize_t set_temp_max(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf, size_t count)
+static ssize_t temp_max_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct adm1021_data *data = dev_get_drvdata(dev);
@@ -225,9 +225,9 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }

-static ssize_t set_temp_min(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf, size_t count)
+static ssize_t temp_min_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct adm1021_data *data = dev_get_drvdata(dev);
@@ -287,21 +287,17 @@ static ssize_t set_low_power(struct devi
 }


-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
-			  set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
-			  set_temp_min, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
-			  set_temp_max, 1);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
-			  set_temp_min, 1);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp_min, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_min, temp_min, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 2);

 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 static DEVICE_ATTR(low_power, S_IWUSR | S_IRUGO, show_low_power, set_low_power);
diff -u -p a/drivers/hwmon/lineage-pem.c b/drivers/hwmon/lineage-pem.c
--- a/drivers/hwmon/lineage-pem.c
+++ b/drivers/hwmon/lineage-pem.c
@@ -282,7 +282,7 @@ static long pem_get_fan(u8 *data, int le
  * Show boolean, either a fault or an alarm.
  * .nr points to the register, .index is the bit mask to check
  */
-static ssize_t pem_show_bool(struct device *dev,
+static ssize_t pem_bool_show(struct device *dev,
 			     struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(da);
@@ -296,7 +296,7 @@ static ssize_t pem_show_bool(struct devi
 	return snprintf(buf, PAGE_SIZE, "%d\n", !!status);
 }

-static ssize_t pem_show_data(struct device *dev, struct device_attribute *da,
+static ssize_t pem_data_show(struct device *dev, struct device_attribute *da,
 			     char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -312,7 +312,7 @@ static ssize_t pem_show_data(struct devi
 	return snprintf(buf, PAGE_SIZE, "%ld\n", value);
 }

-static ssize_t pem_show_input(struct device *dev, struct device_attribute *da,
+static ssize_t pem_input_show(struct device *dev, struct device_attribute *da,
 			      char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -328,7 +328,7 @@ static ssize_t pem_show_input(struct dev
 	return snprintf(buf, PAGE_SIZE, "%ld\n", value);
 }

-static ssize_t pem_show_fan(struct device *dev, struct device_attribute *da,
+static ssize_t pem_fan_show(struct device *dev, struct device_attribute *da,
 			    char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -345,53 +345,42 @@ static ssize_t pem_show_fan(struct devic
 }

 /* Voltages */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, pem_show_data, NULL,
-			  PEM_DATA_VOUT_LSB);
-static SENSOR_DEVICE_ATTR_2(in1_alarm, S_IRUGO, pem_show_bool, NULL,
-			    PEM_DATA_ALARM_1, ALRM1_VOUT_OUT_LIMIT);
-static SENSOR_DEVICE_ATTR_2(in1_crit_alarm, S_IRUGO, pem_show_bool, NULL,
-			    PEM_DATA_ALARM_1, ALRM1_OV_VOLT_SHUTDOWN);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, pem_show_input, NULL,
-			  PEM_INPUT_VOLTAGE);
-static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, pem_show_bool, NULL,
-			    PEM_DATA_ALARM_1,
-			    ALRM1_VIN_OUT_LIMIT | ALRM1_PRIMARY_FAULT);
+static SENSOR_DEVICE_ATTR_RO(in1_input, pem_data, PEM_DATA_VOUT_LSB);
+static SENSOR_DEVICE_ATTR_2_RO(in1_alarm, pem_bool, PEM_DATA_ALARM_1,
+			       ALRM1_VOUT_OUT_LIMIT);
+static SENSOR_DEVICE_ATTR_2_RO(in1_crit_alarm, pem_bool, PEM_DATA_ALARM_1,
+			       ALRM1_OV_VOLT_SHUTDOWN);
+static SENSOR_DEVICE_ATTR_RO(in2_input, pem_input, PEM_INPUT_VOLTAGE);
+static SENSOR_DEVICE_ATTR_2_RO(in2_alarm, pem_bool, PEM_DATA_ALARM_1,
+			       ALRM1_VIN_OUT_LIMIT | ALRM1_PRIMARY_FAULT);

 /* Currents */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, pem_show_data, NULL,
-			  PEM_DATA_CURRENT);
-static SENSOR_DEVICE_ATTR_2(curr1_alarm, S_IRUGO, pem_show_bool, NULL,
-			    PEM_DATA_ALARM_1, ALRM1_VIN_OVERCURRENT);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, pem_data, PEM_DATA_CURRENT);
+static SENSOR_DEVICE_ATTR_2_RO(curr1_alarm, pem_bool, PEM_DATA_ALARM_1,
+			       ALRM1_VIN_OVERCURRENT);

 /* Power */
-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, pem_show_input, NULL,
-			  PEM_INPUT_POWER_LSB);
-static SENSOR_DEVICE_ATTR_2(power1_alarm, S_IRUGO, pem_show_bool, NULL,
-			    PEM_DATA_ALARM_1, ALRM1_POWER_LIMIT);
+static SENSOR_DEVICE_ATTR_RO(power1_input, pem_input, PEM_INPUT_POWER_LSB);
+static SENSOR_DEVICE_ATTR_2_RO(power1_alarm, pem_bool, PEM_DATA_ALARM_1,
+			       ALRM1_POWER_LIMIT);

 /* Fans */
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, pem_show_fan, NULL,
-			  PEM_FAN_FAN1);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, pem_show_fan, NULL,
-			  PEM_FAN_FAN2);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, pem_show_fan, NULL,
-			  PEM_FAN_FAN3);
-static SENSOR_DEVICE_ATTR_2(fan1_alarm, S_IRUGO, pem_show_bool, NULL,
-			    PEM_DATA_ALARM_2, ALRM2_FAN_FAULT);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, pem_fan, PEM_FAN_FAN1);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, pem_fan, PEM_FAN_FAN2);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, pem_fan, PEM_FAN_FAN3);
+static SENSOR_DEVICE_ATTR_2_RO(fan1_alarm, pem_bool, PEM_DATA_ALARM_2,
+			       ALRM2_FAN_FAULT);

 /* Temperatures */
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, pem_show_data, NULL,
-			  PEM_DATA_TEMP);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, pem_show_data, NULL,
-			  PEM_DATA_TEMP_MAX);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, pem_show_data, NULL,
-			  PEM_DATA_TEMP_CRIT);
-static SENSOR_DEVICE_ATTR_2(temp1_alarm, S_IRUGO, pem_show_bool, NULL,
-			    PEM_DATA_ALARM_1, ALRM1_TEMP_WARNING);
-static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO, pem_show_bool, NULL,
-			    PEM_DATA_ALARM_1, ALRM1_TEMP_SHUTDOWN);
-static SENSOR_DEVICE_ATTR_2(temp1_fault, S_IRUGO, pem_show_bool, NULL,
-			    PEM_DATA_ALARM_2, ALRM2_TEMP_FAULT);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, pem_data, PEM_DATA_TEMP);
+static SENSOR_DEVICE_ATTR_RO(temp1_max, pem_data, PEM_DATA_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit, pem_data, PEM_DATA_TEMP_CRIT);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_alarm, pem_bool, PEM_DATA_ALARM_1,
+			       ALRM1_TEMP_WARNING);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_crit_alarm, pem_bool, PEM_DATA_ALARM_1,
+			       ALRM1_TEMP_SHUTDOWN);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_fault, pem_bool, PEM_DATA_ALARM_2,
+			       ALRM2_TEMP_FAULT);

 static struct attribute *pem_attributes[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -568,22 +568,23 @@ in_reg(13);
 in_reg(14);
 in_reg(15);

-static ssize_t show_in16(struct device *dev, struct device_attribute *attr,
+static ssize_t in16_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", INS_FROM_REG(16, data->in[16]) -
 		NEG12_OFFSET);
 }
-static ssize_t show_in16_min(struct device *dev, struct device_attribute *attr,
+static ssize_t in16_min_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", INS_FROM_REG(16, data->in_min[16])
 		- NEG12_OFFSET);
 }
-static ssize_t set_in16_min(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t in16_min_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -603,15 +604,16 @@ static ssize_t set_in16_min(struct devic
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t show_in16_max(struct device *dev, struct device_attribute *attr,
+static ssize_t in16_max_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", INS_FROM_REG(16, data->in_max[16])
 			- NEG12_OFFSET);
 }
-static ssize_t set_in16_max(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t in16_max_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -632,11 +634,9 @@ static ssize_t set_in16_max(struct devic
 	return count;
 }

-static SENSOR_DEVICE_ATTR(in16_input, S_IRUGO, show_in16, NULL, 16);
-static SENSOR_DEVICE_ATTR(in16_min, S_IRUGO | S_IWUSR, show_in16_min,
-			  set_in16_min, 16);
-static SENSOR_DEVICE_ATTR(in16_max, S_IRUGO | S_IWUSR, show_in16_max,
-			  set_in16_max, 16);
+static SENSOR_DEVICE_ATTR_RO(in16_input, in16, 16);
+static SENSOR_DEVICE_ATTR_RW(in16_min, in16_min, 16);
+static SENSOR_DEVICE_ATTR_RW(in16_max, in16_max, 16);


 /* Now add fan read/write functions */
@@ -1111,7 +1111,7 @@ static ssize_t show_alarms_reg(struct de

 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
@@ -1119,34 +1119,34 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%ld\n", (data->alarms >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in9_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in11_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in12_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in13_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(in14_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(in15_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(in16_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 14);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 15);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 16);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 17);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 18);
-static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 19);
-static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 20);
-static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL, 21);
-static SENSOR_DEVICE_ATTR(fan7_alarm, S_IRUGO, show_alarm, NULL, 22);
-static SENSOR_DEVICE_ATTR(fan8_alarm, S_IRUGO, show_alarm, NULL, 23);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 24);
-static SENSOR_DEVICE_ATTR(in10_alarm, S_IRUGO, show_alarm, NULL, 25);
-static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 26);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in9_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in11_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in12_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in13_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(in14_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(in15_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(in16_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 13);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 14);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, alarm, 15);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 16);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 17);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, 18);
+static SENSOR_DEVICE_ATTR_RO(fan4_alarm, alarm, 19);
+static SENSOR_DEVICE_ATTR_RO(fan5_alarm, alarm, 20);
+static SENSOR_DEVICE_ATTR_RO(fan6_alarm, alarm, 21);
+static SENSOR_DEVICE_ATTR_RO(fan7_alarm, alarm, 22);
+static SENSOR_DEVICE_ATTR_RO(fan8_alarm, alarm, 23);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 24);
+static SENSOR_DEVICE_ATTR_RO(in10_alarm, alarm, 25);
+static SENSOR_DEVICE_ATTR_RO(in8_alarm, alarm, 26);

 static ssize_t show_alarm_mask(struct device *dev,
 			       struct device_attribute *attr, char *buf)
diff -u -p a/drivers/hwmon/ina209.c b/drivers/hwmon/ina209.c
--- a/drivers/hwmon/ina209.c
+++ b/drivers/hwmon/ina209.c
@@ -230,9 +230,9 @@ static u16 ina209_reg_from_interval(u16
 	return (config & 0xf807) | (adc << 3) | (adc << 7);
 }

-static ssize_t ina209_set_interval(struct device *dev,
-				   struct device_attribute *da,
-				   const char *buf, size_t count)
+static ssize_t ina209_interval_store(struct device *dev,
+				     struct device_attribute *da,
+				     const char *buf, size_t count)
 {
 	struct ina209_data *data = ina209_update_device(dev);
 	long val;
@@ -257,7 +257,7 @@ static ssize_t ina209_set_interval(struc
 	return count;
 }

-static ssize_t ina209_show_interval(struct device *dev,
+static ssize_t ina209_interval_show(struct device *dev,
 				    struct device_attribute *da, char *buf)
 {
 	struct ina209_data *data = dev_get_drvdata(dev);
@@ -279,10 +279,9 @@ static u16 ina209_reset_history_regs[] =
 	INA209_POWER_PEAK
 };

-static ssize_t ina209_reset_history(struct device *dev,
-				    struct device_attribute *da,
-				    const char *buf,
-				    size_t count)
+static ssize_t ina209_rehistory_store(struct device *dev,
+				      struct device_attribute *da,
+				      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct ina209_data *data = dev_get_drvdata(dev);
@@ -306,10 +305,9 @@ static ssize_t ina209_reset_history(stru
 	return count;
 }

-static ssize_t ina209_set_value(struct device *dev,
-				struct device_attribute *da,
-				const char *buf,
-				size_t count)
+static ssize_t ina209_value_store(struct device *dev,
+				  struct device_attribute *da,
+				  const char *buf, size_t count)
 {
 	struct ina209_data *data = ina209_update_device(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -337,7 +335,7 @@ abort:
 	return count;
 }

-static ssize_t ina209_show_value(struct device *dev,
+static ssize_t ina209_value_show(struct device *dev,
 				 struct device_attribute *da,
 				 char *buf)
 {
@@ -352,7 +350,7 @@ static ssize_t ina209_show_value(struct
 	return snprintf(buf, PAGE_SIZE, "%ld\n", val);
 }

-static ssize_t ina209_show_alarm(struct device *dev,
+static ssize_t ina209_alarm_show(struct device *dev,
 				 struct device_attribute *da,
 				 char *buf)
 {
@@ -374,82 +372,65 @@ static ssize_t ina209_show_alarm(struct
 }

 /* Shunt voltage, history, limits, alarms */
-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina209_show_value, NULL,
-			  INA209_SHUNT_VOLTAGE);
-static SENSOR_DEVICE_ATTR(in0_input_highest, S_IRUGO, ina209_show_value, NULL,
-			  INA209_SHUNT_VOLTAGE_POS_PEAK);
-static SENSOR_DEVICE_ATTR(in0_input_lowest, S_IRUGO, ina209_show_value, NULL,
-			  INA209_SHUNT_VOLTAGE_NEG_PEAK);
-static SENSOR_DEVICE_ATTR(in0_reset_history, S_IWUSR, NULL,
-			  ina209_reset_history, (1 << 0) | (1 << 1));
-static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR, ina209_show_value,
-			  ina209_set_value, INA209_SHUNT_VOLTAGE_POS_WARN);
-static SENSOR_DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR, ina209_show_value,
-			  ina209_set_value, INA209_SHUNT_VOLTAGE_NEG_WARN);
-static SENSOR_DEVICE_ATTR(in0_crit_max, S_IRUGO | S_IWUSR, ina209_show_value,
-			  ina209_set_value, INA209_CRITICAL_DAC_POS);
-static SENSOR_DEVICE_ATTR(in0_crit_min, S_IRUGO | S_IWUSR, ina209_show_value,
-			  ina209_set_value, INA209_CRITICAL_DAC_NEG);
-
-static SENSOR_DEVICE_ATTR(in0_min_alarm,  S_IRUGO, ina209_show_alarm, NULL,
-			  1 << 11);
-static SENSOR_DEVICE_ATTR(in0_max_alarm, S_IRUGO, ina209_show_alarm, NULL,
-			  1 << 12);
-static SENSOR_DEVICE_ATTR(in0_crit_min_alarm, S_IRUGO, ina209_show_alarm, NULL,
-			  1 << 6);
-static SENSOR_DEVICE_ATTR(in0_crit_max_alarm, S_IRUGO, ina209_show_alarm, NULL,
-			  1 << 7);
+static SENSOR_DEVICE_ATTR_RO(in0_input, ina209_value, INA209_SHUNT_VOLTAGE);
+static SENSOR_DEVICE_ATTR_RO(in0_input_highest, ina209_value,
+			     INA209_SHUNT_VOLTAGE_POS_PEAK);
+static SENSOR_DEVICE_ATTR_RO(in0_input_lowest, ina209_value,
+			     INA209_SHUNT_VOLTAGE_NEG_PEAK);
+static SENSOR_DEVICE_ATTR_WO(in0_reset_history, ina209_rehistory,
+			     (1 << 0) | (1 << 1));
+static SENSOR_DEVICE_ATTR_RW(in0_max, ina209_value,
+			     INA209_SHUNT_VOLTAGE_POS_WARN);
+static SENSOR_DEVICE_ATTR_RW(in0_min, ina209_value,
+			     INA209_SHUNT_VOLTAGE_NEG_WARN);
+static SENSOR_DEVICE_ATTR_RW(in0_crit_max, ina209_value,
+			     INA209_CRITICAL_DAC_POS);
+static SENSOR_DEVICE_ATTR_RW(in0_crit_min, ina209_value,
+			     INA209_CRITICAL_DAC_NEG);
+
+static SENSOR_DEVICE_ATTR_RO(in0_min_alarm,  ina209_alarm, 1 << 11);
+static SENSOR_DEVICE_ATTR_RO(in0_max_alarm, ina209_alarm, 1 << 12);
+static SENSOR_DEVICE_ATTR_RO(in0_crit_min_alarm, ina209_alarm, 1 << 6);
+static SENSOR_DEVICE_ATTR_RO(in0_crit_max_alarm, ina209_alarm, 1 << 7);

 /* Bus voltage, history, limits, alarms */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ina209_show_value, NULL,
-			  INA209_BUS_VOLTAGE);
-static SENSOR_DEVICE_ATTR(in1_input_highest, S_IRUGO, ina209_show_value, NULL,
-			  INA209_BUS_VOLTAGE_MAX_PEAK);
-static SENSOR_DEVICE_ATTR(in1_input_lowest, S_IRUGO, ina209_show_value, NULL,
-			  INA209_BUS_VOLTAGE_MIN_PEAK);
-static SENSOR_DEVICE_ATTR(in1_reset_history, S_IWUSR, NULL,
-			  ina209_reset_history, (1 << 2) | (1 << 3));
-static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO | S_IWUSR, ina209_show_value,
-			  ina209_set_value, INA209_BUS_VOLTAGE_OVER_WARN);
-static SENSOR_DEVICE_ATTR(in1_min, S_IRUGO | S_IWUSR, ina209_show_value,
-			  ina209_set_value, INA209_BUS_VOLTAGE_UNDER_WARN);
-static SENSOR_DEVICE_ATTR(in1_crit_max, S_IRUGO | S_IWUSR, ina209_show_value,
-			  ina209_set_value, INA209_BUS_VOLTAGE_OVER_LIMIT);
-static SENSOR_DEVICE_ATTR(in1_crit_min, S_IRUGO | S_IWUSR, ina209_show_value,
-			  ina209_set_value, INA209_BUS_VOLTAGE_UNDER_LIMIT);
-
-static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ina209_show_alarm, NULL,
-			  1 << 14);
-static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ina209_show_alarm, NULL,
-			  1 << 15);
-static SENSOR_DEVICE_ATTR(in1_crit_min_alarm, S_IRUGO, ina209_show_alarm, NULL,
-			  1 << 9);
-static SENSOR_DEVICE_ATTR(in1_crit_max_alarm, S_IRUGO, ina209_show_alarm, NULL,
-			  1 << 10);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ina209_value, INA209_BUS_VOLTAGE);
+static SENSOR_DEVICE_ATTR_RO(in1_input_highest, ina209_value,
+			     INA209_BUS_VOLTAGE_MAX_PEAK);
+static SENSOR_DEVICE_ATTR_RO(in1_input_lowest, ina209_value,
+			     INA209_BUS_VOLTAGE_MIN_PEAK);
+static SENSOR_DEVICE_ATTR_WO(in1_reset_history, ina209_rehistory,
+			     (1 << 2) | (1 << 3));
+static SENSOR_DEVICE_ATTR_RW(in1_max, ina209_value,
+			     INA209_BUS_VOLTAGE_OVER_WARN);
+static SENSOR_DEVICE_ATTR_RW(in1_min, ina209_value,
+			     INA209_BUS_VOLTAGE_UNDER_WARN);
+static SENSOR_DEVICE_ATTR_RW(in1_crit_max, ina209_value,
+			     INA209_BUS_VOLTAGE_OVER_LIMIT);
+static SENSOR_DEVICE_ATTR_RW(in1_crit_min, ina209_value,
+			     INA209_BUS_VOLTAGE_UNDER_LIMIT);
+
+static SENSOR_DEVICE_ATTR_RO(in1_min_alarm, ina209_alarm, 1 << 14);
+static SENSOR_DEVICE_ATTR_RO(in1_max_alarm, ina209_alarm, 1 << 15);
+static SENSOR_DEVICE_ATTR_RO(in1_crit_min_alarm, ina209_alarm, 1 << 9);
+static SENSOR_DEVICE_ATTR_RO(in1_crit_max_alarm, ina209_alarm, 1 << 10);

 /* Power */
-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina209_show_value, NULL,
-			  INA209_POWER);
-static SENSOR_DEVICE_ATTR(power1_input_highest, S_IRUGO, ina209_show_value,
-			  NULL, INA209_POWER_PEAK);
-static SENSOR_DEVICE_ATTR(power1_reset_history, S_IWUSR, NULL,
-			  ina209_reset_history, 1 << 4);
-static SENSOR_DEVICE_ATTR(power1_max, S_IRUGO | S_IWUSR, ina209_show_value,
-			  ina209_set_value, INA209_POWER_WARN);
-static SENSOR_DEVICE_ATTR(power1_crit, S_IRUGO | S_IWUSR, ina209_show_value,
-			  ina209_set_value, INA209_POWER_OVER_LIMIT);
-
-static SENSOR_DEVICE_ATTR(power1_max_alarm, S_IRUGO, ina209_show_alarm, NULL,
-			  1 << 13);
-static SENSOR_DEVICE_ATTR(power1_crit_alarm, S_IRUGO, ina209_show_alarm, NULL,
-			  1 << 8);
+static SENSOR_DEVICE_ATTR_RO(power1_input, ina209_value, INA209_POWER);
+static SENSOR_DEVICE_ATTR_RO(power1_input_highest, ina209_value,
+			     INA209_POWER_PEAK);
+static SENSOR_DEVICE_ATTR_WO(power1_reset_history, ina209_rehistory, 1 << 4);
+static SENSOR_DEVICE_ATTR_RW(power1_max, ina209_value, INA209_POWER_WARN);
+static SENSOR_DEVICE_ATTR_RW(power1_crit, ina209_value,
+			     INA209_POWER_OVER_LIMIT);
+
+static SENSOR_DEVICE_ATTR_RO(power1_max_alarm, ina209_alarm, 1 << 13);
+static SENSOR_DEVICE_ATTR_RO(power1_crit_alarm, ina209_alarm, 1 << 8);

 /* Current */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ina209_show_value, NULL,
-			  INA209_CURRENT);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ina209_value, INA209_CURRENT);

-static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
-			  ina209_show_interval, ina209_set_interval, 0);
+static SENSOR_DEVICE_ATTR_RW(update_interval, ina209_interval, 0);

 /*
  * Finally, construct an array of pointers to members of the above objects,
diff -u -p a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -69,7 +69,7 @@ struct nct7802_data {
 	struct mutex access_lock; /* for multi-byte read and write operations */
 };

-static ssize_t show_temp_type(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_type_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -84,7 +84,7 @@ static ssize_t show_temp_type(struct dev
 	return sprintf(buf, "%u\n", (mode >> (2 * sattr->index) & 3) + 2);
 }

-static ssize_t store_temp_type(struct device *dev,
+static ssize_t temp_type_store(struct device *dev,
 			       struct device_attribute *attr,
 			       const char *buf, size_t count)
 {
@@ -105,7 +105,7 @@ static ssize_t store_temp_type(struct de
 	return err ? : count;
 }

-static ssize_t show_pwm_mode(struct device *dev, struct device_attribute *attr,
+static ssize_t pwm_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
@@ -123,7 +123,7 @@ static ssize_t show_pwm_mode(struct devi
 	return sprintf(buf, "%u\n", !(regval & (1 << sattr->index)));
 }

-static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
+static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -141,7 +141,7 @@ static ssize_t show_pwm(struct device *d
 	return sprintf(buf, "%d\n", val);
 }

-static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr,
+static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
 			 const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -157,7 +157,7 @@ static ssize_t store_pwm(struct device *
 	return err ? : count;
 }

-static ssize_t show_pwm_enable(struct device *dev,
+static ssize_t pwm_enable_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -172,7 +172,7 @@ static ssize_t show_pwm_enable(struct de
 	return sprintf(buf, "%u\n", enabled + 1);
 }

-static ssize_t store_pwm_enable(struct device *dev,
+static ssize_t pwm_enable_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
@@ -345,7 +345,7 @@ abort:
 	return err;
 }

-static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+static ssize_t in_show(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -359,7 +359,7 @@ static ssize_t show_in(struct device *de
 	return sprintf(buf, "%d\n", voltage);
 }

-static ssize_t store_in(struct device *dev, struct device_attribute *attr,
+static ssize_t in_store(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -377,7 +377,7 @@ static ssize_t store_in(struct device *d
 	return err ? : count;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -391,7 +391,7 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", temp);
 }

-static ssize_t store_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -410,7 +410,7 @@ static ssize_t store_temp(struct device
 	return err ? : count;
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
@@ -424,7 +424,7 @@ static ssize_t show_fan(struct device *d
 	return sprintf(buf, "%d\n", speed);
 }

-static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_min_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -438,7 +438,7 @@ static ssize_t show_fan_min(struct devic
 	return sprintf(buf, "%d\n", speed);
 }

-static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_min_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -454,7 +454,7 @@ static ssize_t store_fan_min(struct devi
 	return err ? : count;
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -471,7 +471,7 @@ static ssize_t show_alarm(struct device
 }

 static ssize_t
-show_beep(struct device *dev, struct device_attribute *attr, char *buf)
+beep_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	struct nct7802_data *data = dev_get_drvdata(dev);
@@ -486,7 +486,7 @@ show_beep(struct device *dev, struct dev
 }

 static ssize_t
-store_beep(struct device *dev, struct device_attribute *attr, const char *buf,
+beep_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	   size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -505,108 +505,64 @@ store_beep(struct device *dev, struct de
 	return err ? : count;
 }

-static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR,
-			  show_temp_type, store_temp_type, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0x01,
-			    REG_TEMP_LSB);
-static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x31, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x30, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x3a, 0);
-
-static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
-			  show_temp_type, store_temp_type, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0x02,
-			    REG_TEMP_LSB);
-static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x33, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x32, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x3b, 0);
-
-static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
-			  show_temp_type, store_temp_type, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0x03,
-			    REG_TEMP_LSB);
-static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x35, 0);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x34, 0);
-static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x3c, 0);
-
-static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 0x04, 0);
-static SENSOR_DEVICE_ATTR_2(temp4_min, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x37, 0);
-static SENSOR_DEVICE_ATTR_2(temp4_max, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x36, 0);
-static SENSOR_DEVICE_ATTR_2(temp4_crit, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x3d, 0);
-
-static SENSOR_DEVICE_ATTR_2(temp5_input, S_IRUGO, show_temp, NULL, 0x06,
-			    REG_TEMP_PECI_LSB);
-static SENSOR_DEVICE_ATTR_2(temp5_min, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x39, 0);
-static SENSOR_DEVICE_ATTR_2(temp5_max, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x38, 0);
-static SENSOR_DEVICE_ATTR_2(temp5_crit, S_IRUGO | S_IWUSR, show_temp,
-			    store_temp, 0x3e, 0);
-
-static SENSOR_DEVICE_ATTR_2(temp6_input, S_IRUGO, show_temp, NULL, 0x07,
-			    REG_TEMP_PECI_LSB);
-
-static SENSOR_DEVICE_ATTR_2(temp1_min_alarm, S_IRUGO, show_alarm, NULL,
-			    0x18, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_min_alarm, S_IRUGO, show_alarm, NULL,
-			    0x18, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_min_alarm, S_IRUGO, show_alarm, NULL,
-			    0x18, 2);
-static SENSOR_DEVICE_ATTR_2(temp4_min_alarm, S_IRUGO, show_alarm, NULL,
-			    0x18, 3);
-static SENSOR_DEVICE_ATTR_2(temp5_min_alarm, S_IRUGO, show_alarm, NULL,
-			    0x18, 4);
-
-static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
-			    0x19, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO, show_alarm, NULL,
-			    0x19, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO, show_alarm, NULL,
-			    0x19, 2);
-static SENSOR_DEVICE_ATTR_2(temp4_max_alarm, S_IRUGO, show_alarm, NULL,
-			    0x19, 3);
-static SENSOR_DEVICE_ATTR_2(temp5_max_alarm, S_IRUGO, show_alarm, NULL,
-			    0x19, 4);
-
-static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO, show_alarm, NULL,
-			    0x1b, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO, show_alarm, NULL,
-			    0x1b, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO, show_alarm, NULL,
-			    0x1b, 2);
-static SENSOR_DEVICE_ATTR_2(temp4_crit_alarm, S_IRUGO, show_alarm, NULL,
-			    0x1b, 3);
-static SENSOR_DEVICE_ATTR_2(temp5_crit_alarm, S_IRUGO, show_alarm, NULL,
-			    0x1b, 4);
-
-static SENSOR_DEVICE_ATTR_2(temp1_fault, S_IRUGO, show_alarm, NULL, 0x17, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_fault, S_IRUGO, show_alarm, NULL, 0x17, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_fault, S_IRUGO, show_alarm, NULL, 0x17, 2);
-
-static SENSOR_DEVICE_ATTR_2(temp1_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 2);
-static SENSOR_DEVICE_ATTR_2(temp4_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 3);
-static SENSOR_DEVICE_ATTR_2(temp5_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 4);
-static SENSOR_DEVICE_ATTR_2(temp6_beep, S_IRUGO | S_IWUSR, show_beep,
-			    store_beep, 0x5c, 5);
+static SENSOR_DEVICE_ATTR_RW(temp1_type, temp_type, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0x01, REG_TEMP_LSB);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_min, temp, 0x31, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0x30, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0x3a, 0);
+
+static SENSOR_DEVICE_ATTR_RW(temp2_type, temp_type, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 0x02, REG_TEMP_LSB);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_min, temp, 0x33, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp, 0x32, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_crit, temp, 0x3b, 0);
+
+static SENSOR_DEVICE_ATTR_RW(temp3_type, temp_type, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 0x03, REG_TEMP_LSB);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_min, temp, 0x35, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp, 0x34, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_crit, temp, 0x3c, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp4_input, temp, 0x04, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_min, temp, 0x37, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_max, temp, 0x36, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_crit, temp, 0x3d, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp5_input, temp, 0x06, REG_TEMP_PECI_LSB);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_min, temp, 0x39, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_max, temp, 0x38, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_crit, temp, 0x3e, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp6_input, temp, 0x07, REG_TEMP_PECI_LSB);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp1_min_alarm, alarm, 0x18, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_min_alarm, alarm, 0x18, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_min_alarm, alarm, 0x18, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_min_alarm, alarm, 0x18, 3);
+static SENSOR_DEVICE_ATTR_2_RO(temp5_min_alarm, alarm, 0x18, 4);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp1_max_alarm, alarm, 0x19, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_max_alarm, alarm, 0x19, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_max_alarm, alarm, 0x19, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_max_alarm, alarm, 0x19, 3);
+static SENSOR_DEVICE_ATTR_2_RO(temp5_max_alarm, alarm, 0x19, 4);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp1_crit_alarm, alarm, 0x1b, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_crit_alarm, alarm, 0x1b, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_crit_alarm, alarm, 0x1b, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_crit_alarm, alarm, 0x1b, 3);
+static SENSOR_DEVICE_ATTR_2_RO(temp5_crit_alarm, alarm, 0x1b, 4);
+
+static SENSOR_DEVICE_ATTR_2_RO(temp1_fault, alarm, 0x17, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_fault, alarm, 0x17, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_fault, alarm, 0x17, 2);
+
+static SENSOR_DEVICE_ATTR_2_RW(temp1_beep, beep, 0x5c, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_beep, beep, 0x5c, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_beep, beep, 0x5c, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_beep, beep, 0x5c, 3);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_beep, beep, 0x5c, 4);
+static SENSOR_DEVICE_ATTR_2_RW(temp6_beep, beep, 0x5c, 5);

 static struct attribute *nct7802_temp_attrs[] = {
 	&sensor_dev_attr_temp1_type.dev_attr.attr,
@@ -709,43 +665,31 @@ static struct attribute_group nct7802_te
 	.is_visible = nct7802_temp_is_visible,
 };

-static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0);
-static SENSOR_DEVICE_ATTR_2(in0_min, S_IRUGO | S_IWUSR, show_in, store_in,
-			    0, 1);
-static SENSOR_DEVICE_ATTR_2(in0_max, S_IRUGO | S_IWUSR, show_in, store_in,
-			    0, 2);
-static SENSOR_DEVICE_ATTR_2(in0_alarm, S_IRUGO, show_alarm, NULL, 0x1e, 3);
-static SENSOR_DEVICE_ATTR_2(in0_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5a, 3);
-
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 1, 0);
-
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 2, 0);
-static SENSOR_DEVICE_ATTR_2(in2_min, S_IRUGO | S_IWUSR, show_in, store_in,
-			    2, 1);
-static SENSOR_DEVICE_ATTR_2(in2_max, S_IRUGO | S_IWUSR, show_in, store_in,
-			    2, 2);
-static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, show_alarm, NULL, 0x1e, 0);
-static SENSOR_DEVICE_ATTR_2(in2_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5a, 0);
-
-static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 3, 0);
-static SENSOR_DEVICE_ATTR_2(in3_min, S_IRUGO | S_IWUSR, show_in, store_in,
-			    3, 1);
-static SENSOR_DEVICE_ATTR_2(in3_max, S_IRUGO | S_IWUSR, show_in, store_in,
-			    3, 2);
-static SENSOR_DEVICE_ATTR_2(in3_alarm, S_IRUGO, show_alarm, NULL, 0x1e, 1);
-static SENSOR_DEVICE_ATTR_2(in3_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5a, 1);
-
-static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 4, 0);
-static SENSOR_DEVICE_ATTR_2(in4_min, S_IRUGO | S_IWUSR, show_in, store_in,
-			    4, 1);
-static SENSOR_DEVICE_ATTR_2(in4_max, S_IRUGO | S_IWUSR, show_in, store_in,
-			    4, 2);
-static SENSOR_DEVICE_ATTR_2(in4_alarm, S_IRUGO, show_alarm, NULL, 0x1e, 2);
-static SENSOR_DEVICE_ATTR_2(in4_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5a, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in0_input, in, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in0_min, in, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in0_max, in, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in0_alarm, alarm, 0x1e, 3);
+static SENSOR_DEVICE_ATTR_2_RW(in0_beep, beep, 0x5a, 3);
+
+static SENSOR_DEVICE_ATTR_2_RO(in1_input, in, 1, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(in2_input, in, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in2_min, in, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in2_max, in, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in2_alarm, alarm, 0x1e, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in2_beep, beep, 0x5a, 0);
+
+static SENSOR_DEVICE_ATTR_2_RO(in3_input, in, 3, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in3_min, in, 3, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in3_max, in, 3, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in3_alarm, alarm, 0x1e, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in3_beep, beep, 0x5a, 1);
+
+static SENSOR_DEVICE_ATTR_2_RO(in4_input, in, 4, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in4_min, in, 4, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in4_max, in, 4, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in4_alarm, alarm, 0x1e, 2);
+static SENSOR_DEVICE_ATTR_2_RW(in4_beep, beep, 0x5a, 2);

 static struct attribute *nct7802_in_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
@@ -807,45 +751,33 @@ static struct attribute_group nct7802_in
 	.is_visible = nct7802_in_is_visible,
 };

-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0x10);
-static SENSOR_DEVICE_ATTR_2(fan1_min, S_IRUGO | S_IWUSR, show_fan_min,
-			    store_fan_min, 0x49, 0x4c);
-static SENSOR_DEVICE_ATTR_2(fan1_alarm, S_IRUGO, show_alarm, NULL, 0x1a, 0);
-static SENSOR_DEVICE_ATTR_2(fan1_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5b, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 0x11);
-static SENSOR_DEVICE_ATTR_2(fan2_min, S_IRUGO | S_IWUSR, show_fan_min,
-			    store_fan_min, 0x4a, 0x4d);
-static SENSOR_DEVICE_ATTR_2(fan2_alarm, S_IRUGO, show_alarm, NULL, 0x1a, 1);
-static SENSOR_DEVICE_ATTR_2(fan2_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5b, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 0x12);
-static SENSOR_DEVICE_ATTR_2(fan3_min, S_IRUGO | S_IWUSR, show_fan_min,
-			    store_fan_min, 0x4b, 0x4e);
-static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, show_alarm, NULL, 0x1a, 2);
-static SENSOR_DEVICE_ATTR_2(fan3_beep, S_IRUGO | S_IWUSR, show_beep, store_beep,
-			    0x5b, 2);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0x10);
+static SENSOR_DEVICE_ATTR_2_RW(fan1_min, fan_min, 0x49, 0x4c);
+static SENSOR_DEVICE_ATTR_2_RO(fan1_alarm, alarm, 0x1a, 0);
+static SENSOR_DEVICE_ATTR_2_RW(fan1_beep, beep, 0x5b, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 0x11);
+static SENSOR_DEVICE_ATTR_2_RW(fan2_min, fan_min, 0x4a, 0x4d);
+static SENSOR_DEVICE_ATTR_2_RO(fan2_alarm, alarm, 0x1a, 1);
+static SENSOR_DEVICE_ATTR_2_RW(fan2_beep, beep, 0x5b, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan, 0x12);
+static SENSOR_DEVICE_ATTR_2_RW(fan3_min, fan_min, 0x4b, 0x4e);
+static SENSOR_DEVICE_ATTR_2_RO(fan3_alarm, alarm, 0x1a, 2);
+static SENSOR_DEVICE_ATTR_2_RW(fan3_beep, beep, 0x5b, 2);

 /* 7.2.89 Fan Control Output Type */
-static SENSOR_DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL, 0);
-static SENSOR_DEVICE_ATTR(pwm2_mode, S_IRUGO, show_pwm_mode, NULL, 1);
-static SENSOR_DEVICE_ATTR(pwm3_mode, S_IRUGO, show_pwm_mode, NULL, 2);
+static SENSOR_DEVICE_ATTR_RO(pwm1_mode, pwm_mode, 0);
+static SENSOR_DEVICE_ATTR_RO(pwm2_mode, pwm_mode, 1);
+static SENSOR_DEVICE_ATTR_RO(pwm3_mode, pwm_mode, 2);

 /* 7.2.91... Fan Control Output Value */
-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_pwm,
-			  REG_PWM(0));
-static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_pwm,
-			  REG_PWM(1));
-static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_pwm,
-			  REG_PWM(2));
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, REG_PWM(0));
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, REG_PWM(1));
+static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, REG_PWM(2));

 /* 7.2.95... Temperature to Fan mapping Relationships Register */
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
-			  store_pwm_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
-			  store_pwm_enable, 1);
-static SENSOR_DEVICE_ATTR(pwm3_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
-			  store_pwm_enable, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_enable, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwm_enable, 2);

 static struct attribute *nct7802_fan_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
@@ -903,73 +835,46 @@ static struct attribute_group nct7802_pw
 };

 /* 7.2.115... 0x80-0x83, 0x84 Temperature (X-axis) transition */
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x80, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x81, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x82, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point4_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x83, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point5_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x84, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_temp, temp, 0x80, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_temp, temp, 0x81, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_temp, temp, 0x82, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point4_temp, temp, 0x83, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point5_temp, temp, 0x84, 0);

 /* 7.2.120... 0x85-0x88 PWM (Y-axis) transition */
-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x85);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x86);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point3_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x87);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point4_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x88);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point5_pwm, S_IRUGO, show_pwm, NULL, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm, 0x85);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm, 0x86);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_pwm, pwm, 0x87);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_pwm, pwm, 0x88);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point5_pwm, pwm, 0);

 /* 7.2.124 Table 2 X-axis Transition Point 1 Register */
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x90, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x91, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x92, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point4_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x93, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point5_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0x94, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_temp, temp, 0x90, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_temp, temp, 0x91, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point3_temp, temp, 0x92, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point4_temp, temp, 0x93, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point5_temp, temp, 0x94, 0);

 /* 7.2.129 Table 2 Y-axis Transition Point 1 Register */
-static SENSOR_DEVICE_ATTR(pwm2_auto_point1_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x95);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point2_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x96);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point3_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x97);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point4_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0x98);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point5_pwm, S_IRUGO, show_pwm, NULL, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point1_pwm, pwm, 0x95);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point2_pwm, pwm, 0x96);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point3_pwm, pwm, 0x97);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point4_pwm, pwm, 0x98);
+static SENSOR_DEVICE_ATTR_RO(pwm2_auto_point5_pwm, pwm, 0);

 /* 7.2.133 Table 3 X-axis Transition Point 1 Register */
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0xA0, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0xA1, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0xA2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point4_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0xA3, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point5_temp, S_IRUGO | S_IWUSR,
-			    show_temp, store_temp, 0xA4, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_temp, temp, 0xA0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_temp, temp, 0xA1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_temp, temp, 0xA2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point4_temp, temp, 0xA3, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point5_temp, temp, 0xA4, 0);

 /* 7.2.138 Table 3 Y-axis Transition Point 1 Register */
-static SENSOR_DEVICE_ATTR(pwm3_auto_point1_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0xA5);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point2_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0xA6);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point3_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0xA7);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point4_pwm, S_IRUGO | S_IWUSR,
-			  show_pwm, store_pwm, 0xA8);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point5_pwm, S_IRUGO, show_pwm, NULL, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point1_pwm, pwm, 0xA5);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point2_pwm, pwm, 0xA6);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point3_pwm, pwm, 0xA7);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point4_pwm, pwm, 0xA8);
+static SENSOR_DEVICE_ATTR_RO(pwm3_auto_point5_pwm, pwm, 0);

 static struct attribute *nct7802_auto_point_attrs[] = {
 	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
diff -u -p a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
--- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -352,7 +352,7 @@ static int fts_watchdog_init(struct fts_
 /*****************************************************************************/
 /* SysFS handler functions						     */
 /*****************************************************************************/
-static ssize_t show_in_value(struct device *dev,
+static ssize_t in_value_show(struct device *dev,
 			     struct device_attribute *devattr, char *buf)
 {
 	struct fts_data *data = dev_get_drvdata(dev);
@@ -366,7 +366,7 @@ static ssize_t show_in_value(struct devi
 	return sprintf(buf, "%u\n", data->volt[index]);
 }

-static ssize_t show_temp_value(struct device *dev,
+static ssize_t temp_value_show(struct device *dev,
 			       struct device_attribute *devattr, char *buf)
 {
 	struct fts_data *data = dev_get_drvdata(dev);
@@ -380,7 +380,7 @@ static ssize_t show_temp_value(struct de
 	return sprintf(buf, "%u\n", data->temp_input[index]);
 }

-static ssize_t show_temp_fault(struct device *dev,
+static ssize_t temp_fault_show(struct device *dev,
 			       struct device_attribute *devattr, char *buf)
 {
 	struct fts_data *data = dev_get_drvdata(dev);
@@ -440,7 +440,7 @@ error:
 	return ret;
 }

-static ssize_t show_fan_value(struct device *dev,
+static ssize_t fan_value_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct fts_data *data = dev_get_drvdata(dev);
@@ -454,7 +454,7 @@ static ssize_t show_fan_value(struct dev
 	return sprintf(buf, "%u\n", data->fan_input[index]);
 }

-static ssize_t show_fan_source(struct device *dev,
+static ssize_t fan_source_show(struct device *dev,
 			       struct device_attribute *devattr, char *buf)
 {
 	struct fts_data *data = dev_get_drvdata(dev);
@@ -518,39 +518,39 @@ error:
 /*****************************************************************************/

 /* Temprature sensors */
-static SENSOR_DEVICE_ATTR(temp1_input,  S_IRUGO, show_temp_value, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input,  S_IRUGO, show_temp_value, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input,  S_IRUGO, show_temp_value, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_input,  S_IRUGO, show_temp_value, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_input,  S_IRUGO, show_temp_value, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_input,  S_IRUGO, show_temp_value, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp7_input,  S_IRUGO, show_temp_value, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp8_input,  S_IRUGO, show_temp_value, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp9_input,  S_IRUGO, show_temp_value, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp10_input, S_IRUGO, show_temp_value, NULL, 9);
-static SENSOR_DEVICE_ATTR(temp11_input, S_IRUGO, show_temp_value, NULL, 10);
-static SENSOR_DEVICE_ATTR(temp12_input, S_IRUGO, show_temp_value, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp13_input, S_IRUGO, show_temp_value, NULL, 12);
-static SENSOR_DEVICE_ATTR(temp14_input, S_IRUGO, show_temp_value, NULL, 13);
-static SENSOR_DEVICE_ATTR(temp15_input, S_IRUGO, show_temp_value, NULL, 14);
-static SENSOR_DEVICE_ATTR(temp16_input, S_IRUGO, show_temp_value, NULL, 15);
-
-static SENSOR_DEVICE_ATTR(temp1_fault,  S_IRUGO, show_temp_fault, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_fault,  S_IRUGO, show_temp_fault, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_fault,  S_IRUGO, show_temp_fault, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_fault,  S_IRUGO, show_temp_fault, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_fault,  S_IRUGO, show_temp_fault, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_fault,  S_IRUGO, show_temp_fault, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp7_fault,  S_IRUGO, show_temp_fault, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp8_fault,  S_IRUGO, show_temp_fault, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp9_fault,  S_IRUGO, show_temp_fault, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp10_fault, S_IRUGO, show_temp_fault, NULL, 9);
-static SENSOR_DEVICE_ATTR(temp11_fault, S_IRUGO, show_temp_fault, NULL, 10);
-static SENSOR_DEVICE_ATTR(temp12_fault, S_IRUGO, show_temp_fault, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp13_fault, S_IRUGO, show_temp_fault, NULL, 12);
-static SENSOR_DEVICE_ATTR(temp14_fault, S_IRUGO, show_temp_fault, NULL, 13);
-static SENSOR_DEVICE_ATTR(temp15_fault, S_IRUGO, show_temp_fault, NULL, 14);
-static SENSOR_DEVICE_ATTR(temp16_fault, S_IRUGO, show_temp_fault, NULL, 15);
+static SENSOR_DEVICE_ATTR_RO(temp1_input,  temp_value, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input,  temp_value, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input,  temp_value, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input,  temp_value, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_input,  temp_value, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_input,  temp_value, 5);
+static SENSOR_DEVICE_ATTR_RO(temp7_input,  temp_value, 6);
+static SENSOR_DEVICE_ATTR_RO(temp8_input,  temp_value, 7);
+static SENSOR_DEVICE_ATTR_RO(temp9_input,  temp_value, 8);
+static SENSOR_DEVICE_ATTR_RO(temp10_input, temp_value, 9);
+static SENSOR_DEVICE_ATTR_RO(temp11_input, temp_value, 10);
+static SENSOR_DEVICE_ATTR_RO(temp12_input, temp_value, 11);
+static SENSOR_DEVICE_ATTR_RO(temp13_input, temp_value, 12);
+static SENSOR_DEVICE_ATTR_RO(temp14_input, temp_value, 13);
+static SENSOR_DEVICE_ATTR_RO(temp15_input, temp_value, 14);
+static SENSOR_DEVICE_ATTR_RO(temp16_input, temp_value, 15);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_fault,  temp_fault, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault,  temp_fault, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault,  temp_fault, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_fault,  temp_fault, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_fault,  temp_fault, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_fault,  temp_fault, 5);
+static SENSOR_DEVICE_ATTR_RO(temp7_fault,  temp_fault, 6);
+static SENSOR_DEVICE_ATTR_RO(temp8_fault,  temp_fault, 7);
+static SENSOR_DEVICE_ATTR_RO(temp9_fault,  temp_fault, 8);
+static SENSOR_DEVICE_ATTR_RO(temp10_fault, temp_fault, 9);
+static SENSOR_DEVICE_ATTR_RO(temp11_fault, temp_fault, 10);
+static SENSOR_DEVICE_ATTR_RO(temp12_fault, temp_fault, 11);
+static SENSOR_DEVICE_ATTR_RO(temp13_fault, temp_fault, 12);
+static SENSOR_DEVICE_ATTR_RO(temp14_fault, temp_fault, 13);
+static SENSOR_DEVICE_ATTR_RO(temp15_fault, temp_fault, 14);
+static SENSOR_DEVICE_ATTR_RO(temp16_fault, temp_fault, 15);

 static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO | S_IWUSR, show_temp_alarm,
 			  clear_temp_alarm, 0);
@@ -640,23 +640,23 @@ static struct attribute *fts_temp_attrs[
 };

 /* Fans */
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_value, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_value, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan_value, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan_value, NULL, 3);
-static SENSOR_DEVICE_ATTR(fan5_input, S_IRUGO, show_fan_value, NULL, 4);
-static SENSOR_DEVICE_ATTR(fan6_input, S_IRUGO, show_fan_value, NULL, 5);
-static SENSOR_DEVICE_ATTR(fan7_input, S_IRUGO, show_fan_value, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan8_input, S_IRUGO, show_fan_value, NULL, 7);
-
-static SENSOR_DEVICE_ATTR(fan1_source, S_IRUGO, show_fan_source, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_source, S_IRUGO, show_fan_source, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_source, S_IRUGO, show_fan_source, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_source, S_IRUGO, show_fan_source, NULL, 3);
-static SENSOR_DEVICE_ATTR(fan5_source, S_IRUGO, show_fan_source, NULL, 4);
-static SENSOR_DEVICE_ATTR(fan6_source, S_IRUGO, show_fan_source, NULL, 5);
-static SENSOR_DEVICE_ATTR(fan7_source, S_IRUGO, show_fan_source, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan8_source, S_IRUGO, show_fan_source, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_value, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_value, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan_value, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan_value, 3);
+static SENSOR_DEVICE_ATTR_RO(fan5_input, fan_value, 4);
+static SENSOR_DEVICE_ATTR_RO(fan6_input, fan_value, 5);
+static SENSOR_DEVICE_ATTR_RO(fan7_input, fan_value, 6);
+static SENSOR_DEVICE_ATTR_RO(fan8_input, fan_value, 7);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_source, fan_source, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_source, fan_source, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_source, fan_source, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_source, fan_source, 3);
+static SENSOR_DEVICE_ATTR_RO(fan5_source, fan_source, 4);
+static SENSOR_DEVICE_ATTR_RO(fan6_source, fan_source, 5);
+static SENSOR_DEVICE_ATTR_RO(fan7_source, fan_source, 6);
+static SENSOR_DEVICE_ATTR_RO(fan8_source, fan_source, 7);

 static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO | S_IWUSR,
 			 show_fan_alarm, clear_fan_alarm, 0);
@@ -706,10 +706,10 @@ static struct attribute *fts_fan_attrs[]
 };

 /* Voltages */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in_value, NULL, 0);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in_value, NULL, 1);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in_value, NULL, 2);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in_value, NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(in1_input, in_value, 0);
+static SENSOR_DEVICE_ATTR_RO(in2_input, in_value, 1);
+static SENSOR_DEVICE_ATTR_RO(in3_input, in_value, 2);
+static SENSOR_DEVICE_ATTR_RO(in4_input, in_value, 3);
 static struct attribute *fts_voltage_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/ltc4151.c b/drivers/hwmon/ltc4151.c
--- a/drivers/hwmon/ltc4151.c
+++ b/drivers/hwmon/ltc4151.c
@@ -131,7 +131,7 @@ static int ltc4151_get_value(struct ltc4
 	return val;
 }

-static ssize_t ltc4151_show_value(struct device *dev,
+static ssize_t ltc4151_value_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -148,14 +148,11 @@ static ssize_t ltc4151_show_value(struct
 /*
  * Input voltages.
  */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4151_show_value, NULL,
-			  LTC4151_VIN_H);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4151_show_value, NULL,
-			  LTC4151_ADIN_H);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ltc4151_value, LTC4151_VIN_H);
+static SENSOR_DEVICE_ATTR_RO(in2_input, ltc4151_value, LTC4151_ADIN_H);

 /* Currents (via sense resistor) */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4151_show_value, NULL,
-			  LTC4151_SENSE_H);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ltc4151_value, LTC4151_SENSE_H);

 /*
  * Finally, construct an array of pointers to members of the above objects,
diff -u -p a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -269,12 +269,12 @@ static struct ibmpex_bmc_data *get_bmc_d
 	return NULL;
 }

-static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	return sprintf(buf, "%s\n", DRVNAME);
 }
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(name, name, 0);

 static ssize_t ibmpex_show_sensor(struct device *dev,
 				  struct device_attribute *devattr,
@@ -289,10 +289,9 @@ static ssize_t ibmpex_show_sensor(struct
 		       data->sensors[attr->index].values[attr->nr] * mult);
 }

-static ssize_t ibmpex_reset_high_low(struct device *dev,
-				     struct device_attribute *devattr,
-				     const char *buf,
-				     size_t count)
+static ssize_t ibmpex_rehigh_low_store(struct device *dev,
+				       struct device_attribute *devattr,
+				       const char *buf, size_t count)
 {
 	struct ibmpex_bmc_data *data = dev_get_drvdata(dev);

@@ -301,8 +300,7 @@ static ssize_t ibmpex_reset_high_low(str
 	return count;
 }

-static SENSOR_DEVICE_ATTR(reset_high_low, S_IWUSR, NULL,
-			  ibmpex_reset_high_low, 0);
+static SENSOR_DEVICE_ATTR_WO(reset_high_low, ibmpex_rehigh_low, 0);

 static int is_power_sensor(const char *sensor_id, int len)
 {
diff -u -p a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -434,7 +434,7 @@ static ssize_t set_vrm(struct device *de
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);

 /* Alarms */
-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
@@ -443,19 +443,19 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (data->alarms & nr) ? 1 : 0);
 }

-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 0x0010);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 0x0020);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 0x0040);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 0x4000);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 0x8000);
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0x0001);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 0x0002);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 0x0004);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 0x0008);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 0x0100);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 0x0200);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 0x0400);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 0x0800);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 0x0010);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 0x0020);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 0x0040);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 0x4000);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 0x8000);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0x0001);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 0x0002);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 0x0004);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 0x0008);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 0x0100);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 0x0200);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 0x0400);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, alarm, 0x0800);

 static struct attribute *smsc47m192_attributes[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -211,7 +211,7 @@ abort:
 	return ret;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -225,7 +225,7 @@ static ssize_t show_temp(struct device *
 		       DIV_ROUND_CLOSEST(data->temp[index] * 125, 32));
 }

-static ssize_t show_alarm(struct device *dev,
+static ssize_t alarm_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -238,7 +238,7 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u", !!(data->status & mask));
 }

-static ssize_t show_type(struct device *dev, struct device_attribute *attr,
+static ssize_t type_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -251,8 +251,8 @@ static ssize_t show_type(struct device *
 	return sprintf(buf, data->sensor_type & mask ? "1\n" : "2\n");
 }

-static ssize_t set_type(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t type_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -282,7 +282,7 @@ static ssize_t set_type(struct device *d
 	return count;
 }

-static ssize_t show_tcrit2(struct device *dev, struct device_attribute *attr,
+static ssize_t tcrit2_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -295,8 +295,8 @@ static ssize_t show_tcrit2(struct device
 	return sprintf(buf, "%u", data->tcrit2[index] * 1000);
 }

-static ssize_t set_tcrit2(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t tcrit2_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr(attr)->index;
@@ -320,7 +320,7 @@ static ssize_t set_tcrit2(struct device
 	return count;
 }

-static ssize_t show_tcrit2_hyst(struct device *dev,
+static ssize_t tcrit2_hyst_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -335,7 +335,7 @@ static ssize_t show_tcrit2_hyst(struct d
 		       ((int)data->tcrit2[index] - (int)data->thyst) * 1000);
 }

-static ssize_t show_tcrit1(struct device *dev, struct device_attribute *attr,
+static ssize_t tcrit1_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -344,8 +344,8 @@ static ssize_t show_tcrit1(struct device
 	return sprintf(buf, "%u", data->tcrit1[index] * 1000);
 }

-static ssize_t set_tcrit1(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t tcrit1_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr(attr)->index;
@@ -369,7 +369,7 @@ static ssize_t set_tcrit1(struct device
 	return count;
 }

-static ssize_t show_tcrit1_hyst(struct device *dev,
+static ssize_t tcrit1_hyst_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -384,9 +384,9 @@ static ssize_t show_tcrit1_hyst(struct d
 		       ((int)data->tcrit1[index] - (int)data->thyst) * 1000);
 }

-static ssize_t set_tcrit1_hyst(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t tcrit1_hyst_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr(attr)->index;
@@ -411,7 +411,7 @@ static ssize_t set_tcrit1_hyst(struct de
 	return count;
 }

-static ssize_t show_offset(struct device *dev, struct device_attribute *attr,
+static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
@@ -424,8 +424,8 @@ static ssize_t show_offset(struct device
 	return sprintf(buf, "%d", data->toffset[index] * 500);
 }

-static ssize_t set_offset(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t offset_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	int index = to_sensor_dev_attr(attr)->index;
@@ -491,80 +491,53 @@ static ssize_t set_interval(struct devic
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp, NULL, 4);
-
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL,
-			  BIT(0) | BIT(1));
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL,
-			  BIT(2) | BIT(3));
-static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_alarm, NULL,
-			  BIT(4) | BIT(5));
-static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_alarm, NULL,
-			  BIT(6) | BIT(7));
-
-static SENSOR_DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type,
-			  BIT(1));
-static SENSOR_DEVICE_ATTR(temp3_type, S_IWUSR | S_IRUGO, show_type, set_type,
-			  BIT(2));
-static SENSOR_DEVICE_ATTR(temp4_type, S_IWUSR | S_IRUGO, show_type, set_type,
-			  BIT(3));
-static SENSOR_DEVICE_ATTR(temp5_type, S_IWUSR | S_IRUGO, show_type, set_type,
-			  BIT(4));
-
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_tcrit1,
-			  set_tcrit1, 0);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_tcrit2,
-			  set_tcrit2, 0);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_tcrit2,
-			  set_tcrit2, 1);
-static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_tcrit1,
-			  set_tcrit1, 3);
-static SENSOR_DEVICE_ATTR(temp5_max, S_IWUSR | S_IRUGO, show_tcrit1,
-			  set_tcrit1, 4);
-
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_tcrit1_hyst,
-			  set_tcrit1_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO, show_tcrit2_hyst, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IRUGO, show_tcrit2_hyst, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IRUGO, show_tcrit1_hyst, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_max_hyst, S_IRUGO, show_tcrit1_hyst, NULL, 4);
-
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(0 + 8));
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(1 + 16));
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(2 + 16));
-static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(3 + 8));
-static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(4 + 8));
-
-static SENSOR_DEVICE_ATTR(temp2_crit, S_IWUSR | S_IRUGO, show_tcrit1,
-			  set_tcrit1, 1);
-static SENSOR_DEVICE_ATTR(temp3_crit, S_IWUSR | S_IRUGO, show_tcrit1,
-			  set_tcrit1, 2);
-
-static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_tcrit1_hyst, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_tcrit1_hyst, NULL, 2);
-
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(1 + 8));
-static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO, show_alarm, NULL,
-			  BIT(2 + 8));
-
-static SENSOR_DEVICE_ATTR(temp2_offset, S_IWUSR | S_IRUGO, show_offset,
-			  set_offset, 0);
-static SENSOR_DEVICE_ATTR(temp3_offset, S_IWUSR | S_IRUGO, show_offset,
-			  set_offset, 1);
-static SENSOR_DEVICE_ATTR(temp4_offset, S_IWUSR | S_IRUGO, show_offset,
-			  set_offset, 2);
-static SENSOR_DEVICE_ATTR(temp5_offset, S_IWUSR | S_IRUGO, show_offset,
-			  set_offset, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_input, temp, 4);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, BIT(0) | BIT(1));
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, BIT(2) | BIT(3));
+static SENSOR_DEVICE_ATTR_RO(temp4_fault, alarm, BIT(4) | BIT(5));
+static SENSOR_DEVICE_ATTR_RO(temp5_fault, alarm, BIT(6) | BIT(7));
+
+static SENSOR_DEVICE_ATTR_RW(temp2_type, type, BIT(1));
+static SENSOR_DEVICE_ATTR_RW(temp3_type, type, BIT(2));
+static SENSOR_DEVICE_ATTR_RW(temp4_type, type, BIT(3));
+static SENSOR_DEVICE_ATTR_RW(temp5_type, type, BIT(4));
+
+static SENSOR_DEVICE_ATTR_RW(temp1_max, tcrit1, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, tcrit2, 0);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, tcrit2, 1);
+static SENSOR_DEVICE_ATTR_RW(temp4_max, tcrit1, 3);
+static SENSOR_DEVICE_ATTR_RW(temp5_max, tcrit1, 4);
+
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, tcrit1_hyst, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_hyst, tcrit2_hyst, 0);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_hyst, tcrit2_hyst, 1);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_hyst, tcrit1_hyst, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_max_hyst, tcrit1_hyst, 4);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, BIT(0 + 8));
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, BIT(1 + 16));
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, alarm, BIT(2 + 16));
+static SENSOR_DEVICE_ATTR_RO(temp4_max_alarm, alarm, BIT(3 + 8));
+static SENSOR_DEVICE_ATTR_RO(temp5_max_alarm, alarm, BIT(4 + 8));
+
+static SENSOR_DEVICE_ATTR_RW(temp2_crit, tcrit1, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_crit, tcrit1, 2);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_hyst, tcrit1_hyst, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_hyst, tcrit1_hyst, 2);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, BIT(1 + 8));
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_alarm, alarm, BIT(2 + 8));
+
+static SENSOR_DEVICE_ATTR_RW(temp2_offset, offset, 0);
+static SENSOR_DEVICE_ATTR_RW(temp3_offset, offset, 1);
+static SENSOR_DEVICE_ATTR_RW(temp4_offset, offset, 2);
+static SENSOR_DEVICE_ATTR_RW(temp5_offset, offset, 3);

 static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_interval,
 		   set_interval);
diff -u -p a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -629,40 +629,22 @@ out:
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, temp1_input_show, NULL, 0);
-static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO, humidity1_input_show,
-			  NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
-			  temp1_limit_show, temp1_limit_store,
-			  limit_max);
-static SENSOR_DEVICE_ATTR(humidity1_max, S_IRUGO | S_IWUSR,
-			  humidity1_limit_show, humidity1_limit_store,
-			  limit_max);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR,
-			  temp1_limit_show, temp1_limit_store,
-			  limit_max_hyst);
-static SENSOR_DEVICE_ATTR(humidity1_max_hyst, S_IRUGO | S_IWUSR,
-			  humidity1_limit_show, humidity1_limit_store,
-			  limit_max_hyst);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR,
-			  temp1_limit_show, temp1_limit_store,
-			  limit_min);
-static SENSOR_DEVICE_ATTR(humidity1_min, S_IRUGO | S_IWUSR,
-			  humidity1_limit_show, humidity1_limit_store,
-			  limit_min);
-static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO | S_IWUSR,
-			  temp1_limit_show, temp1_limit_store,
-			  limit_min_hyst);
-static SENSOR_DEVICE_ATTR(humidity1_min_hyst, S_IRUGO | S_IWUSR,
-			  humidity1_limit_show, humidity1_limit_store,
-			  limit_min_hyst);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, temp1_alarm_show, NULL, 0);
-static SENSOR_DEVICE_ATTR(humidity1_alarm, S_IRUGO, humidity1_alarm_show,
-			  NULL, 0);
-static SENSOR_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR,
-			  heater_enable_show, heater_enable_store, 0);
-static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
-			  update_interval_show, update_interval_store, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp1_input, 0);
+static SENSOR_DEVICE_ATTR_RO(humidity1_input, humidity1_input, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp1_limit, limit_max);
+static SENSOR_DEVICE_ATTR_RW(humidity1_max, humidity1_limit, limit_max);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp1_limit, limit_max_hyst);
+static SENSOR_DEVICE_ATTR_RW(humidity1_max_hyst, humidity1_limit,
+			     limit_max_hyst);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp1_limit, limit_min);
+static SENSOR_DEVICE_ATTR_RW(humidity1_min, humidity1_limit, limit_min);
+static SENSOR_DEVICE_ATTR_RW(temp1_min_hyst, temp1_limit, limit_min_hyst);
+static SENSOR_DEVICE_ATTR_RW(humidity1_min_hyst, humidity1_limit,
+			     limit_min_hyst);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, temp1_alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(humidity1_alarm, humidity1_alarm, 0);
+static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(update_interval, update_interval, 0);

 static struct attribute *sht3x_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -96,7 +96,7 @@ static int ads7871_write_reg8(struct spi
 	return spi_write(spi, tmp, sizeof(tmp));
 }

-static ssize_t show_voltage(struct device *dev,
+static ssize_t voltage_show(struct device *dev,
 		struct device_attribute *da, char *buf)
 {
 	struct ads7871_data *pdata = dev_get_drvdata(dev);
@@ -138,14 +138,14 @@ static ssize_t show_voltage(struct devic
 	}
 }

-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_voltage, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_voltage, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_voltage, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_voltage, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_voltage, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_voltage, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_voltage, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_voltage, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(in0_input, voltage, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_input, voltage, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, voltage, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, voltage, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, voltage, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_input, voltage, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_input, voltage, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_input, voltage, 7);

 static struct attribute *ads7871_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/tmp103.c b/drivers/hwmon/tmp103.c
--- a/drivers/hwmon/tmp103.c
+++ b/drivers/hwmon/tmp103.c
@@ -61,7 +61,7 @@ static inline u8 tmp103_mc_to_reg(int va
 	return DIV_ROUND_CLOSEST(val, 1000);
 }

-static ssize_t tmp103_show_temp(struct device *dev,
+static ssize_t tmp103_temp_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
@@ -77,9 +77,9 @@ static ssize_t tmp103_show_temp(struct d
 	return sprintf(buf, "%d\n", tmp103_reg_to_mc(regval));
 }

-static ssize_t tmp103_set_temp(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t tmp103_temp_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
 	struct regmap *regmap = dev_get_drvdata(dev);
@@ -94,14 +94,11 @@ static ssize_t tmp103_set_temp(struct de
 	return ret ? ret : count;
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, tmp103_show_temp, NULL ,
-			  TMP103_TEMP_REG);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, tmp103_temp, TMP103_TEMP_REG);

-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, tmp103_show_temp,
-			  tmp103_set_temp, TMP103_TLOW_REG);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, tmp103_temp, TMP103_TLOW_REG);

-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, tmp103_show_temp,
-			  tmp103_set_temp, TMP103_THIGH_REG);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, tmp103_temp, TMP103_THIGH_REG);

 static struct attribute *tmp103_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -340,7 +340,7 @@ static ssize_t set_fan_min(struct device
 	return count;
 }

-static ssize_t show_fan_div(struct device *dev, struct device_attribute *da,
+static ssize_t fan_div_show(struct device *dev, struct device_attribute *da,
 			    char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -354,8 +354,8 @@ static ssize_t show_fan_div(struct devic
  * least surprise; the user doesn't expect the fan minimum to change just
  * because the divisor changed.
  */
-static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
-			   const char *buf, size_t count)
+static ssize_t fan_div_store(struct device *dev, struct device_attribute *da,
+			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm78_data *data = dev_get_drvdata(dev);
@@ -424,11 +424,9 @@ show_fan_offset(2);
 show_fan_offset(3);

 /* Fan 3 divisor is locked in H/W */
-static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
-		show_fan_div, set_fan_div, 0);
-static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
-		show_fan_div, set_fan_div, 1);
-static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO, show_fan_div, NULL, 2);
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_div, fan_div, 2);

 /* VID */
 static ssize_t show_vid(struct device *dev, struct device_attribute *da,
@@ -448,24 +446,24 @@ static ssize_t show_alarms(struct device
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *da,
 			  char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	int nr = to_sensor_dev_attr(da)->index;
 	return sprintf(buf, "%u\n", (data->alarms >> nr) & 1);
 }
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);

 static struct attribute *lm78_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/adm1029.c b/drivers/hwmon/adm1029.c
--- a/drivers/hwmon/adm1029.c
+++ b/drivers/hwmon/adm1029.c
@@ -170,7 +170,7 @@ static struct adm1029_data *adm1029_upda
  */

 static ssize_t
-show_temp(struct device *dev, struct device_attribute *devattr, char *buf)
+temp_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm1029_data *data = adm1029_update_device(dev);
@@ -178,7 +178,7 @@ show_temp(struct device *dev, struct dev
 }

 static ssize_t
-show_fan(struct device *dev, struct device_attribute *devattr, char *buf)
+fan_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm1029_data *data = adm1029_update_device(dev);
@@ -195,7 +195,7 @@ show_fan(struct device *dev, struct devi
 }

 static ssize_t
-show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
+fan_div_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm1029_data *data = adm1029_update_device(dev);
@@ -204,8 +204,9 @@ show_fan_div(struct device *dev, struct
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[attr->index]));
 }

-static ssize_t set_fan_div(struct device *dev,
-	    struct device_attribute *devattr, const char *buf, size_t count)
+static ssize_t fan_div_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct adm1029_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -257,28 +258,26 @@ static ssize_t set_fan_div(struct device
  * Access rights on sysfs. S_IRUGO: Is Readable by User, Group and Others
  *			   S_IWUSR: Is Writable by User.
  */
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_temp, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO, show_temp, NULL, 5);
-
-static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO, show_temp, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO, show_temp, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO, show_temp, NULL, 8);
-
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
-
-static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO, show_fan, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO, show_fan, NULL, 3);
-
-static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
-			  show_fan_div, set_fan_div, 0);
-static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
-			  show_fan_div, set_fan_div, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_max, temp, 3);
+static SENSOR_DEVICE_ATTR_RO(temp2_max, temp, 4);
+static SENSOR_DEVICE_ATTR_RO(temp3_max, temp, 5);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_min, temp, 6);
+static SENSOR_DEVICE_ATTR_RO(temp2_min, temp, 7);
+static SENSOR_DEVICE_ATTR_RO(temp3_min, temp, 8);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 1);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_min, fan, 2);
+static SENSOR_DEVICE_ATTR_RO(fan2_min, fan, 3);
+
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 1);

 static struct attribute *adm1029_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -837,27 +837,27 @@ show_alarms_reg(struct device *dev, stru
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);

 static ssize_t
-show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
+alarm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 16);
-static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 17);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, alarm, 16);
+static SENSOR_DEVICE_ATTR_RO(in8_alarm, alarm, 17);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 13);

 static ssize_t
 show_beep_mask(struct device *dev, struct device_attribute *attr, char *buf)
@@ -899,7 +899,7 @@ static DEVICE_ATTR(beep_mask, S_IRUGO |
 		   show_beep_mask, store_beep_mask);

 static ssize_t
-show_beep(struct device *dev, struct device_attribute *attr, char *buf)
+beep_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	int bitnr = to_sensor_dev_attr(attr)->index;
@@ -907,7 +907,7 @@ show_beep(struct device *dev, struct dev
 }

 static ssize_t
-store_beep(struct device *dev, struct device_attribute *attr,
+beep_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
@@ -956,41 +956,25 @@ store_beep(struct device *dev, struct de
 	return count;
 }

-static SENSOR_DEVICE_ATTR(in0_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 0);
-static SENSOR_DEVICE_ATTR(in1_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 1);
-static SENSOR_DEVICE_ATTR(in2_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 2);
-static SENSOR_DEVICE_ATTR(in3_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 3);
-static SENSOR_DEVICE_ATTR(in4_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 8);
-static SENSOR_DEVICE_ATTR(in5_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 9);
-static SENSOR_DEVICE_ATTR(in6_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 10);
-static SENSOR_DEVICE_ATTR(in7_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 16);
-static SENSOR_DEVICE_ATTR(in8_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 17);
-static SENSOR_DEVICE_ATTR(fan1_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 6);
-static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 7);
-static SENSOR_DEVICE_ATTR(fan3_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 11);
-static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 4);
-static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 5);
-static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 13);
-static SENSOR_DEVICE_ATTR(beep_enable, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 15);
+static SENSOR_DEVICE_ATTR_RW(in0_beep, beep, 0);
+static SENSOR_DEVICE_ATTR_RW(in1_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RW(in2_beep, beep, 2);
+static SENSOR_DEVICE_ATTR_RW(in3_beep, beep, 3);
+static SENSOR_DEVICE_ATTR_RW(in4_beep, beep, 8);
+static SENSOR_DEVICE_ATTR_RW(in5_beep, beep, 9);
+static SENSOR_DEVICE_ATTR_RW(in6_beep, beep, 10);
+static SENSOR_DEVICE_ATTR_RW(in7_beep, beep, 16);
+static SENSOR_DEVICE_ATTR_RW(in8_beep, beep, 17);
+static SENSOR_DEVICE_ATTR_RW(fan1_beep, beep, 6);
+static SENSOR_DEVICE_ATTR_RW(fan2_beep, beep, 7);
+static SENSOR_DEVICE_ATTR_RW(fan3_beep, beep, 11);
+static SENSOR_DEVICE_ATTR_RW(temp1_beep, beep, 4);
+static SENSOR_DEVICE_ATTR_RW(temp2_beep, beep, 5);
+static SENSOR_DEVICE_ATTR_RW(temp3_beep, beep, 13);
+static SENSOR_DEVICE_ATTR_RW(beep_enable, beep, 15);

 static ssize_t
-show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
+fan_div_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = w83627hf_update_device(dev);
@@ -1004,7 +988,7 @@ show_fan_div(struct device *dev, struct
  * because the divisor changed.
  */
 static ssize_t
-store_fan_div(struct device *dev, struct device_attribute *devattr,
+fan_div_store(struct device *dev, struct device_attribute *devattr,
 	      const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
@@ -1044,15 +1028,12 @@ store_fan_div(struct device *dev, struct
 	return count;
 }

-static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO|S_IWUSR,
-			  show_fan_div, store_fan_div, 0);
-static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO|S_IWUSR,
-			  show_fan_div, store_fan_div, 1);
-static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO|S_IWUSR,
-			  show_fan_div, store_fan_div, 2);
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_div, fan_div, 2);

 static ssize_t
-show_pwm(struct device *dev, struct device_attribute *devattr, char *buf)
+pwm_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = w83627hf_update_device(dev);
@@ -1060,7 +1041,7 @@ show_pwm(struct device *dev, struct devi
 }

 static ssize_t
-store_pwm(struct device *dev, struct device_attribute *devattr,
+pwm_store(struct device *dev, struct device_attribute *devattr,
 	  const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
@@ -1093,12 +1074,12 @@ store_pwm(struct device *dev, struct dev
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 1);
-static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, 2);

 static ssize_t
-show_pwm_enable(struct device *dev, struct device_attribute *devattr, char *buf)
+pwm_enable_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = w83627hf_update_device(dev);
@@ -1106,7 +1087,7 @@ show_pwm_enable(struct device *dev, stru
 }

 static ssize_t
-store_pwm_enable(struct device *dev, struct device_attribute *devattr,
+pwm_enable_store(struct device *dev, struct device_attribute *devattr,
 	  const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
@@ -1131,15 +1112,12 @@ store_pwm_enable(struct device *dev, str
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
-						  store_pwm_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
-						  store_pwm_enable, 1);
-static SENSOR_DEVICE_ATTR(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
-						  store_pwm_enable, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_enable, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwm_enable, 2);

 static ssize_t
-show_pwm_freq(struct device *dev, struct device_attribute *devattr, char *buf)
+pwm_freq_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
 	struct w83627hf_data *data = w83627hf_update_device(dev);
@@ -1152,7 +1130,7 @@ show_pwm_freq(struct device *dev, struct
 }

 static ssize_t
-store_pwm_freq(struct device *dev, struct device_attribute *devattr,
+pwm_freq_store(struct device *dev, struct device_attribute *devattr,
 	       const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(devattr)->index;
@@ -1183,12 +1161,9 @@ store_pwm_freq(struct device *dev, struc
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1_freq, S_IRUGO|S_IWUSR,
-			  show_pwm_freq, store_pwm_freq, 0);
-static SENSOR_DEVICE_ATTR(pwm2_freq, S_IRUGO|S_IWUSR,
-			  show_pwm_freq, store_pwm_freq, 1);
-static SENSOR_DEVICE_ATTR(pwm3_freq, S_IRUGO|S_IWUSR,
-			  show_pwm_freq, store_pwm_freq, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm1_freq, pwm_freq, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_freq, pwm_freq, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_freq, pwm_freq, 2);

 static ssize_t
 show_temp_type(struct device *dev, struct device_attribute *devattr,
diff -u -p a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -209,8 +209,8 @@ static int max6650_set_operating_mode(st
 	return 0;
 }

-static ssize_t get_fan(struct device *dev, struct device_attribute *devattr,
-		       char *buf)
+static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
+			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct max6650_data *data = max6650_update_device(dev);
@@ -510,8 +510,8 @@ static ssize_t set_div(struct device *de
  * 1 = alarm
  */

-static ssize_t get_alarm(struct device *dev, struct device_attribute *devattr,
-			 char *buf)
+static ssize_t alarm_show(struct device *dev,
+			  struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct max6650_data *data = max6650_update_device(dev);
@@ -530,24 +530,19 @@ static ssize_t get_alarm(struct device *
 	return sprintf(buf, "%d\n", alarm);
 }

-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, get_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, get_fan, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, get_fan, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, get_fan, NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan, 3);
 static DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO, get_target, set_target);
 static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, get_div, set_div);
 static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, get_enable, set_enable);
 static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
-static SENSOR_DEVICE_ATTR(fan1_max_alarm, S_IRUGO, get_alarm, NULL,
-			  MAX6650_ALRM_MAX);
-static SENSOR_DEVICE_ATTR(fan1_min_alarm, S_IRUGO, get_alarm, NULL,
-			  MAX6650_ALRM_MIN);
-static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, get_alarm, NULL,
-			  MAX6650_ALRM_TACH);
-static SENSOR_DEVICE_ATTR(gpio1_alarm, S_IRUGO, get_alarm, NULL,
-			  MAX6650_ALRM_GPIO1);
-static SENSOR_DEVICE_ATTR(gpio2_alarm, S_IRUGO, get_alarm, NULL,
-			  MAX6650_ALRM_GPIO2);
+static SENSOR_DEVICE_ATTR_RO(fan1_max_alarm, alarm, MAX6650_ALRM_MAX);
+static SENSOR_DEVICE_ATTR_RO(fan1_min_alarm, alarm, MAX6650_ALRM_MIN);
+static SENSOR_DEVICE_ATTR_RO(fan1_fault, alarm, MAX6650_ALRM_TACH);
+static SENSOR_DEVICE_ATTR_RO(gpio1_alarm, alarm, MAX6650_ALRM_GPIO1);
+static SENSOR_DEVICE_ATTR_RO(gpio2_alarm, alarm, MAX6650_ALRM_GPIO2);

 static umode_t max6650_attrs_visible(struct kobject *kobj, struct attribute *a,
 				    int n)
diff -u -p a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -70,8 +70,9 @@ static int mc13783_adc_read(struct devic
 	return 0;
 }

-static ssize_t mc13783_adc_read_bp(struct device *dev,
-		struct device_attribute *devattr, char *buf)
+static ssize_t mc13783_adc_read_bp_show(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
 {
 	unsigned val;
 	struct platform_device *pdev = to_platform_device(dev);
@@ -93,8 +94,9 @@ static ssize_t mc13783_adc_read_bp(struc
 	return sprintf(buf, "%u\n", val);
 }

-static ssize_t mc13783_adc_read_gp(struct device *dev,
-		struct device_attribute *devattr, char *buf)
+static ssize_t mc13783_adc_read_gp_show(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
 {
 	unsigned val;
 	int ret = mc13783_adc_read(dev, devattr, &val);
@@ -112,18 +114,18 @@ static ssize_t mc13783_adc_read_gp(struc
 }

 static DEVICE_ATTR(name, S_IRUGO, mc13783_adc_show_name, NULL);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, mc13783_adc_read_bp, NULL, 2);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, mc13783_adc_read_gp, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, mc13783_adc_read_gp, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, mc13783_adc_read_gp, NULL, 7);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, mc13783_adc_read_gp, NULL, 8);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, mc13783_adc_read_gp, NULL, 9);
-static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, mc13783_adc_read_gp, NULL, 10);
-static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, mc13783_adc_read_gp, NULL, 11);
-static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, mc13783_adc_read_gp, NULL, 12);
-static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, mc13783_adc_read_gp, NULL, 13);
-static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, mc13783_adc_read_gp, NULL, 14);
-static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, mc13783_adc_read_gp, NULL, 15);
+static SENSOR_DEVICE_ATTR_RO(in2_input, mc13783_adc_read_bp, 2);
+static SENSOR_DEVICE_ATTR_RO(in5_input, mc13783_adc_read_gp, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_input, mc13783_adc_read_gp, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_input, mc13783_adc_read_gp, 7);
+static SENSOR_DEVICE_ATTR_RO(in8_input, mc13783_adc_read_gp, 8);
+static SENSOR_DEVICE_ATTR_RO(in9_input, mc13783_adc_read_gp, 9);
+static SENSOR_DEVICE_ATTR_RO(in10_input, mc13783_adc_read_gp, 10);
+static SENSOR_DEVICE_ATTR_RO(in11_input, mc13783_adc_read_gp, 11);
+static SENSOR_DEVICE_ATTR_RO(in12_input, mc13783_adc_read_gp, 12);
+static SENSOR_DEVICE_ATTR_RO(in13_input, mc13783_adc_read_gp, 13);
+static SENSOR_DEVICE_ATTR_RO(in14_input, mc13783_adc_read_gp, 14);
+static SENSOR_DEVICE_ATTR_RO(in15_input, mc13783_adc_read_gp, 15);

 static struct attribute *mc13783_attr_base[] = {
 	&dev_attr_name.attr,
diff -u -p a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -611,27 +611,27 @@ static ssize_t show_alarms(struct device
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct vt8231_data *data = vt8231_update_device(dev);
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp4_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp5_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp6_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp4_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp5_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp6_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 7);

 static ssize_t show_name(struct device *dev, struct device_attribute
 			 *devattr, char *buf)
diff -u -p a/drivers/hwmon/ltc2990.c b/drivers/hwmon/ltc2990.c
--- a/drivers/hwmon/ltc2990.c
+++ b/drivers/hwmon/ltc2990.c
@@ -75,7 +75,7 @@ static int ltc2990_get_value(struct i2c_
 	return 0;
 }

-static ssize_t ltc2990_show_value(struct device *dev,
+static ssize_t ltc2990_value_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -89,14 +89,10 @@ static ssize_t ltc2990_show_value(struct
 	return snprintf(buf, PAGE_SIZE, "%d\n", value);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ltc2990_show_value, NULL,
-			  LTC2990_TINT_MSB);
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc2990_show_value, NULL,
-			  LTC2990_V1_MSB);
-static SENSOR_DEVICE_ATTR(curr2_input, S_IRUGO, ltc2990_show_value, NULL,
-			  LTC2990_V3_MSB);
-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ltc2990_show_value, NULL,
-			  LTC2990_VCC_MSB);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, ltc2990_value, LTC2990_TINT_MSB);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ltc2990_value, LTC2990_V1_MSB);
+static SENSOR_DEVICE_ATTR_RO(curr2_input, ltc2990_value, LTC2990_V3_MSB);
+static SENSOR_DEVICE_ATTR_RO(in0_input, ltc2990_value, LTC2990_VCC_MSB);

 static struct attribute *ltc2990_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/abx500.c b/drivers/hwmon/abx500.c
--- a/drivers/hwmon/abx500.c
+++ b/drivers/hwmon/abx500.c
@@ -121,7 +121,7 @@ static void gpadc_monitor(struct work_st
 }

 /* HWMON sysfs interfaces */
-static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct abx500_temp *data = dev_get_drvdata(dev);
@@ -129,7 +129,7 @@ static ssize_t show_name(struct device *
 	return data->ops.show_name(dev, devattr, buf);
 }

-static ssize_t show_label(struct device *dev,
+static ssize_t label_show(struct device *dev,
 			  struct device_attribute *devattr, char *buf)
 {
 	struct abx500_temp *data = dev_get_drvdata(dev);
@@ -137,7 +137,7 @@ static ssize_t show_label(struct device
 	return data->ops.show_label(dev, devattr, buf);
 }

-static ssize_t show_input(struct device *dev,
+static ssize_t input_show(struct device *dev,
 			  struct device_attribute *devattr, char *buf)
 {
 	int ret, temp;
@@ -153,8 +153,8 @@ static ssize_t show_input(struct device
 }

 /* Set functions (RW nodes) */
-static ssize_t set_min(struct device *dev, struct device_attribute *devattr,
-		       const char *buf, size_t count)
+static ssize_t min_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
 {
 	unsigned long val;
 	struct abx500_temp *data = dev_get_drvdata(dev);
@@ -173,8 +173,8 @@ static ssize_t set_min(struct device *de
 	return count;
 }

-static ssize_t set_max(struct device *dev, struct device_attribute *devattr,
-		       const char *buf, size_t count)
+static ssize_t max_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
 {
 	unsigned long val;
 	struct abx500_temp *data = dev_get_drvdata(dev);
@@ -193,9 +193,9 @@ static ssize_t set_max(struct device *de
 	return count;
 }

-static ssize_t set_max_hyst(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf, size_t count)
+static ssize_t max_hyst_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	unsigned long val;
 	struct abx500_temp *data = dev_get_drvdata(dev);
@@ -215,7 +215,7 @@ static ssize_t set_max_hyst(struct devic
 }

 /* Show functions (RO nodes) */
-static ssize_t show_min(struct device *dev,
+static ssize_t min_show(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
 	struct abx500_temp *data = dev_get_drvdata(dev);
@@ -224,7 +224,7 @@ static ssize_t show_min(struct device *d
 	return sprintf(buf, "%lu\n", data->min[attr->index]);
 }

-static ssize_t show_max(struct device *dev,
+static ssize_t max_show(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
 	struct abx500_temp *data = dev_get_drvdata(dev);
@@ -233,7 +233,7 @@ static ssize_t show_max(struct device *d
 	return sprintf(buf, "%lu\n", data->max[attr->index]);
 }

-static ssize_t show_max_hyst(struct device *dev,
+static ssize_t max_hyst_show(struct device *dev,
 			     struct device_attribute *devattr, char *buf)
 {
 	struct abx500_temp *data = dev_get_drvdata(dev);
@@ -242,7 +242,7 @@ static ssize_t show_max_hyst(struct devi
 	return sprintf(buf, "%lu\n", data->max_hyst[attr->index]);
 }

-static ssize_t show_min_alarm(struct device *dev,
+static ssize_t min_alarm_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct abx500_temp *data = dev_get_drvdata(dev);
@@ -251,7 +251,7 @@ static ssize_t show_min_alarm(struct dev
 	return sprintf(buf, "%d\n", data->min_alarm[attr->index]);
 }

-static ssize_t show_max_alarm(struct device *dev,
+static ssize_t max_alarm_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct abx500_temp *data = dev_get_drvdata(dev);
@@ -273,47 +273,43 @@ static umode_t abx500_attrs_visible(stru
 }

 /* Chip name, required by hwmon */
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(name, name, 0);

 /* GPADC - SENSOR1 */
-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_min, set_min, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_max, set_max, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
-			  show_max_hyst, set_max_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_min_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_max_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_label, label, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, input, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, min, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, max, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, max_hyst, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, min_alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, max_alarm, 0);

 /* GPADC - SENSOR2 */
-static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_min, set_min, 1);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_max, set_max, 1);
-static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IWUSR | S_IRUGO,
-			  show_max_hyst, set_max_hyst, 1);
-static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_min_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_max_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_label, label, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, input, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_min, min, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, max, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max_hyst, max_hyst, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, min_alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, max_alarm, 1);

 /* GPADC - SENSOR3 */
-static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, show_label, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_input, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_min, set_min, 2);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_max, set_max, 2);
-static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IWUSR | S_IRUGO,
-			  show_max_hyst, set_max_hyst, 2);
-static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_min_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_max_alarm, NULL, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_label, label, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, input, 2);
+static SENSOR_DEVICE_ATTR_RW(temp3_min, min, 2);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, max, 2);
+static SENSOR_DEVICE_ATTR_RW(temp3_max_hyst, max_hyst, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_min_alarm, min_alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, max_alarm, 2);

 /* GPADC - SENSOR4 */
-static SENSOR_DEVICE_ATTR(temp4_label, S_IRUGO, show_label, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_input, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_min, set_min, 3);
-static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_max, set_max, 3);
-static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IWUSR | S_IRUGO,
-			  show_max_hyst, set_max_hyst, 3);
-static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO, show_min_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_max_alarm, NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(temp4_label, label, 3);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, input, 3);
+static SENSOR_DEVICE_ATTR_RW(temp4_min, min, 3);
+static SENSOR_DEVICE_ATTR_RW(temp4_max, max, 3);
+static SENSOR_DEVICE_ATTR_RW(temp4_max_hyst, max_hyst, 3);
+static SENSOR_DEVICE_ATTR_RO(temp4_min_alarm, min_alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_alarm, max_alarm, 3);

 static struct attribute *abx500_temp_attributes[] = {
 	&sensor_dev_attr_name.dev_attr.attr,
diff -u -p a/drivers/hwmon/powr1220.c b/drivers/hwmon/powr1220.c
--- a/drivers/hwmon/powr1220.c
+++ b/drivers/hwmon/powr1220.c
@@ -177,7 +177,7 @@ exit:
 }

 /* Shows the voltage associated with the specified ADC channel */
-static ssize_t powr1220_show_voltage(struct device *dev,
+static ssize_t powr1220_voltage_show(struct device *dev,
 	struct device_attribute *dev_attr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
@@ -190,7 +190,7 @@ static ssize_t powr1220_show_voltage(str
 }

 /* Shows the maximum setting associated with the specified ADC channel */
-static ssize_t powr1220_show_max(struct device *dev,
+static ssize_t powr1220_max_show(struct device *dev,
 	struct device_attribute *dev_attr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
@@ -200,7 +200,7 @@ static ssize_t powr1220_show_max(struct
 }

 /* Shows the label associated with the specified ADC channel */
-static ssize_t powr1220_show_label(struct device *dev,
+static ssize_t powr1220_label_show(struct device *dev,
 	struct device_attribute *dev_attr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
@@ -208,92 +208,50 @@ static ssize_t powr1220_show_label(struc
 	return sprintf(buf, "%s\n", input_names[attr->index]);
 }

-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON1);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON2);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON3);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON4);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON5);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON6);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON7);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON8);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON9);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON10);
-static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON11);
-static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VMON12);
-static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VCCA);
-static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, powr1220_show_voltage, NULL,
-	VCCINP);
-
-static SENSOR_DEVICE_ATTR(in0_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON1);
-static SENSOR_DEVICE_ATTR(in1_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON2);
-static SENSOR_DEVICE_ATTR(in2_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON3);
-static SENSOR_DEVICE_ATTR(in3_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON4);
-static SENSOR_DEVICE_ATTR(in4_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON5);
-static SENSOR_DEVICE_ATTR(in5_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON6);
-static SENSOR_DEVICE_ATTR(in6_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON7);
-static SENSOR_DEVICE_ATTR(in7_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON8);
-static SENSOR_DEVICE_ATTR(in8_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON9);
-static SENSOR_DEVICE_ATTR(in9_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON10);
-static SENSOR_DEVICE_ATTR(in10_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON11);
-static SENSOR_DEVICE_ATTR(in11_highest, S_IRUGO, powr1220_show_max, NULL,
-	VMON12);
-static SENSOR_DEVICE_ATTR(in12_highest, S_IRUGO, powr1220_show_max, NULL,
-	VCCA);
-static SENSOR_DEVICE_ATTR(in13_highest, S_IRUGO, powr1220_show_max, NULL,
-	VCCINP);
-
-static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON1);
-static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON2);
-static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON3);
-static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON4);
-static SENSOR_DEVICE_ATTR(in4_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON5);
-static SENSOR_DEVICE_ATTR(in5_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON6);
-static SENSOR_DEVICE_ATTR(in6_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON7);
-static SENSOR_DEVICE_ATTR(in7_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON8);
-static SENSOR_DEVICE_ATTR(in8_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON9);
-static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON10);
-static SENSOR_DEVICE_ATTR(in10_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON11);
-static SENSOR_DEVICE_ATTR(in11_label, S_IRUGO, powr1220_show_label, NULL,
-	VMON12);
-static SENSOR_DEVICE_ATTR(in12_label, S_IRUGO, powr1220_show_label, NULL,
-	VCCA);
-static SENSOR_DEVICE_ATTR(in13_label, S_IRUGO, powr1220_show_label, NULL,
-	VCCINP);
+static SENSOR_DEVICE_ATTR_RO(in0_input, powr1220_voltage, VMON1);
+static SENSOR_DEVICE_ATTR_RO(in1_input, powr1220_voltage, VMON2);
+static SENSOR_DEVICE_ATTR_RO(in2_input, powr1220_voltage, VMON3);
+static SENSOR_DEVICE_ATTR_RO(in3_input, powr1220_voltage, VMON4);
+static SENSOR_DEVICE_ATTR_RO(in4_input, powr1220_voltage, VMON5);
+static SENSOR_DEVICE_ATTR_RO(in5_input, powr1220_voltage, VMON6);
+static SENSOR_DEVICE_ATTR_RO(in6_input, powr1220_voltage, VMON7);
+static SENSOR_DEVICE_ATTR_RO(in7_input, powr1220_voltage, VMON8);
+static SENSOR_DEVICE_ATTR_RO(in8_input, powr1220_voltage, VMON9);
+static SENSOR_DEVICE_ATTR_RO(in9_input, powr1220_voltage, VMON10);
+static SENSOR_DEVICE_ATTR_RO(in10_input, powr1220_voltage, VMON11);
+static SENSOR_DEVICE_ATTR_RO(in11_input, powr1220_voltage, VMON12);
+static SENSOR_DEVICE_ATTR_RO(in12_input, powr1220_voltage, VCCA);
+static SENSOR_DEVICE_ATTR_RO(in13_input, powr1220_voltage, VCCINP);
+
+static SENSOR_DEVICE_ATTR_RO(in0_highest, powr1220_max, VMON1);
+static SENSOR_DEVICE_ATTR_RO(in1_highest, powr1220_max, VMON2);
+static SENSOR_DEVICE_ATTR_RO(in2_highest, powr1220_max, VMON3);
+static SENSOR_DEVICE_ATTR_RO(in3_highest, powr1220_max, VMON4);
+static SENSOR_DEVICE_ATTR_RO(in4_highest, powr1220_max, VMON5);
+static SENSOR_DEVICE_ATTR_RO(in5_highest, powr1220_max, VMON6);
+static SENSOR_DEVICE_ATTR_RO(in6_highest, powr1220_max, VMON7);
+static SENSOR_DEVICE_ATTR_RO(in7_highest, powr1220_max, VMON8);
+static SENSOR_DEVICE_ATTR_RO(in8_highest, powr1220_max, VMON9);
+static SENSOR_DEVICE_ATTR_RO(in9_highest, powr1220_max, VMON10);
+static SENSOR_DEVICE_ATTR_RO(in10_highest, powr1220_max, VMON11);
+static SENSOR_DEVICE_ATTR_RO(in11_highest, powr1220_max, VMON12);
+static SENSOR_DEVICE_ATTR_RO(in12_highest, powr1220_max, VCCA);
+static SENSOR_DEVICE_ATTR_RO(in13_highest, powr1220_max, VCCINP);
+
+static SENSOR_DEVICE_ATTR_RO(in0_label, powr1220_label, VMON1);
+static SENSOR_DEVICE_ATTR_RO(in1_label, powr1220_label, VMON2);
+static SENSOR_DEVICE_ATTR_RO(in2_label, powr1220_label, VMON3);
+static SENSOR_DEVICE_ATTR_RO(in3_label, powr1220_label, VMON4);
+static SENSOR_DEVICE_ATTR_RO(in4_label, powr1220_label, VMON5);
+static SENSOR_DEVICE_ATTR_RO(in5_label, powr1220_label, VMON6);
+static SENSOR_DEVICE_ATTR_RO(in6_label, powr1220_label, VMON7);
+static SENSOR_DEVICE_ATTR_RO(in7_label, powr1220_label, VMON8);
+static SENSOR_DEVICE_ATTR_RO(in8_label, powr1220_label, VMON9);
+static SENSOR_DEVICE_ATTR_RO(in9_label, powr1220_label, VMON10);
+static SENSOR_DEVICE_ATTR_RO(in10_label, powr1220_label, VMON11);
+static SENSOR_DEVICE_ATTR_RO(in11_label, powr1220_label, VMON12);
+static SENSOR_DEVICE_ATTR_RO(in12_label, powr1220_label, VCCA);
+static SENSOR_DEVICE_ATTR_RO(in13_label, powr1220_label, VCCINP);

 static struct attribute *powr1220_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/wm831x-hwmon.c b/drivers/hwmon/wm831x-hwmon.c
--- a/drivers/hwmon/wm831x-hwmon.c
+++ b/drivers/hwmon/wm831x-hwmon.c
@@ -39,7 +39,7 @@ static const char * const input_names[]
 	[WM831X_AUX_BATT_TEMP] = "Battery",
 };

-static ssize_t show_voltage(struct device *dev,
+static ssize_t voltage_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
 	struct wm831x *wm831x = dev_get_drvdata(dev);
@@ -53,7 +53,7 @@ static ssize_t show_voltage(struct devic
 	return sprintf(buf, "%d\n", DIV_ROUND_CLOSEST(ret, 1000));
 }

-static ssize_t show_chip_temp(struct device *dev,
+static ssize_t chip_temp_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	struct wm831x *wm831x = dev_get_drvdata(dev);
@@ -71,7 +71,7 @@ static ssize_t show_chip_temp(struct dev
 	return sprintf(buf, "%d\n", ret);
 }

-static ssize_t show_label(struct device *dev,
+static ssize_t label_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	int channel = to_sensor_dev_attr(attr)->index;
@@ -99,18 +99,14 @@ WM831X_NAMED_VOLTAGE(6, WM831X_AUX_BATT)
 WM831X_NAMED_VOLTAGE(7, WM831X_AUX_WALL);
 WM831X_NAMED_VOLTAGE(8, WM831X_AUX_BKUP_BATT);

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_chip_temp, NULL,
-			  WM831X_AUX_CHIP_TEMP);
-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,
-			  WM831X_AUX_CHIP_TEMP);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, chip_temp, WM831X_AUX_CHIP_TEMP);
+static SENSOR_DEVICE_ATTR_RO(temp1_label, label, WM831X_AUX_CHIP_TEMP);
 /*
  * Report as a voltage since conversion depends on external components
  * and that's what the ABI wants.
  */
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_voltage, NULL,
-			  WM831X_AUX_BATT_TEMP);
-static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL,
-			  WM831X_AUX_BATT_TEMP);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, voltage, WM831X_AUX_BATT_TEMP);
+static SENSOR_DEVICE_ATTR_RO(temp2_label, label, WM831X_AUX_BATT_TEMP);

 static struct attribute *wm831x_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -340,7 +340,7 @@ static int lm63_lut_looks_bad(struct dev
  * Sysfs callback functions and files
  */

-static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
+static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -348,8 +348,8 @@ static ssize_t show_fan(struct device *d
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index]));
 }

-static ssize_t set_fan(struct device *dev, struct device_attribute *dummy,
-		       const char *buf, size_t count)
+static ssize_t fan_store(struct device *dev, struct device_attribute *dummy,
+			 const char *buf, size_t count)
 {
 	struct lm63_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -370,7 +370,7 @@ static ssize_t set_fan(struct device *de
 	return count;
 }

-static ssize_t show_pwm1(struct device *dev, struct device_attribute *devattr,
+static ssize_t pwm1_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -388,8 +388,9 @@ static ssize_t show_pwm1(struct device *
 	return sprintf(buf, "%d\n", pwm);
 }

-static ssize_t set_pwm1(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t pwm1_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm63_data *data = dev_get_drvdata(dev);
@@ -465,7 +466,7 @@ static ssize_t set_pwm1_enable(struct de
  * for local sensor it must not.
  * So we need separate 8bit accessors for local and remote sensor.
  */
-static ssize_t show_local_temp8(struct device *dev,
+static ssize_t local_temp8_show(struct device *dev,
 				struct device_attribute *devattr,
 				char *buf)
 {
@@ -533,7 +534,7 @@ static ssize_t set_temp8(struct device *
 	return count;
 }

-static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp11_show(struct device *dev, struct device_attribute *devattr,
 			   char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -559,8 +560,9 @@ static ssize_t show_temp11(struct device
 	return sprintf(buf, "%d\n", temp + data->temp2_offset);
 }

-static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
-			  const char *buf, size_t count)
+static ssize_t temp11_store(struct device *dev,
+			    struct device_attribute *devattr, const char *buf,
+			    size_t count)
 {
 	static const u8 reg[6] = {
 		LM63_REG_REMOTE_LOW_MSB,
@@ -609,7 +611,7 @@ static ssize_t show_temp2_crit_hyst(stru
 		       - TEMP8_FROM_REG(data->temp2_crit_hyst));
 }

-static ssize_t show_lut_temp_hyst(struct device *dev,
+static ssize_t lut_temp_hyst_show(struct device *dev,
 				  struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -738,7 +740,7 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%u\n", data->alarms);
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *devattr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *devattr,
 			  char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -748,97 +750,69 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan,
-	set_fan, 1);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
+static SENSOR_DEVICE_ATTR_RW(fan1_min, fan, 1);

-static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm1, set_pwm1, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm1, 0);
 static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
 	show_pwm1_enable, set_pwm1_enable);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm1, 1);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 3);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 3);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 2);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_temp_hyst, lut_temp_hyst, 3);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm1, 2);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 4);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 4);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point3_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 3);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point2_temp_hyst, lut_temp_hyst, 4);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_pwm, pwm1, 3);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point3_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 5);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point3_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 5);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point4_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 4);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point3_temp_hyst, lut_temp_hyst, 5);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_pwm, pwm1, 4);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point4_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 6);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point4_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 6);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point5_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 5);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point4_temp_hyst, lut_temp_hyst, 6);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_pwm, pwm1, 5);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point5_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 7);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point5_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 7);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point6_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 6);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point5_temp_hyst, lut_temp_hyst, 7);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point6_pwm, pwm1, 6);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point6_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 8);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point6_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 8);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point7_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 7);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point6_temp_hyst, lut_temp_hyst, 8);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point7_pwm, pwm1, 7);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point7_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 9);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point7_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 9);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point8_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 8);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point7_temp_hyst, lut_temp_hyst, 9);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point8_pwm, pwm1, 8);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point8_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 10);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point8_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 10);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point9_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 9);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point8_temp_hyst, lut_temp_hyst, 10);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point9_pwm, pwm1, 9);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point9_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 11);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point9_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 11);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point10_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 10);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point9_temp_hyst, lut_temp_hyst, 11);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point10_pwm, pwm1, 10);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point10_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 12);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point10_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 12);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point11_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 11);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point10_temp_hyst, lut_temp_hyst, 12);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point11_pwm, pwm1, 11);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point11_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 13);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point11_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 13);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point12_pwm, S_IWUSR | S_IRUGO,
-	show_pwm1, set_pwm1, 12);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point11_temp_hyst, lut_temp_hyst, 13);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point12_pwm, pwm1, 12);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point12_temp, S_IWUSR | S_IRUGO,
 	show_lut_temp, set_temp8, 14);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point12_temp_hyst, S_IRUGO,
-	show_lut_temp_hyst, NULL, 14);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point12_temp_hyst, lut_temp_hyst, 14);

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_local_temp8, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_local_temp8,
-	set_temp8, 1);
-
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp11,
-	set_temp11, 1);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp11,
-	set_temp11, 2);
-static SENSOR_DEVICE_ATTR(temp2_offset, S_IWUSR | S_IRUGO, show_temp11,
-	set_temp11, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, local_temp8, 0);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, local_temp8_show,
+			  set_temp8, 1);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp11, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_min, temp11, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp11, 2);
+static SENSOR_DEVICE_ATTR_RW(temp2_offset, temp11, 3);
 static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_remote_temp8,
 	set_temp8, 2);
 static DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp2_crit_hyst,
@@ -847,12 +821,12 @@ static DEVICE_ATTR(temp2_crit_hyst, S_IW
 static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type);

 /* Individual alarm files */
-static SENSOR_DEVICE_ATTR(fan1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
+static SENSOR_DEVICE_ATTR_RO(fan1_min_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 6);
 /* Raw alarm file for compatibility */
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

diff -u -p a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -519,13 +519,13 @@ static int ntc_read_temp(void *data, int
 	return 0;
 }

-static ssize_t ntc_show_type(struct device *dev,
+static ssize_t ntc_type_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "4\n");
 }

-static ssize_t ntc_show_temp(struct device *dev,
+static ssize_t ntc_temp_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct ntc_data *data = dev_get_drvdata(dev);
@@ -538,8 +538,8 @@ static ssize_t ntc_show_temp(struct devi
 	return sprintf(buf, "%d\n", get_temp_mc(data, ohm));
 }

-static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, ntc_show_type, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ntc_show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_type, ntc_type, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, ntc_temp, 0);

 static struct attribute *ntc_attrs[] = {
 	&sensor_dev_attr_temp1_type.dev_attr.attr,
diff -u -p a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -185,7 +185,7 @@ static struct emc2103_data *emc2103_upda
 }

 static ssize_t
-show_temp(struct device *dev, struct device_attribute *da, char *buf)
+temp_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	int nr = to_sensor_dev_attr(da)->index;
 	struct emc2103_data *data = emc2103_update_device(dev);
@@ -195,7 +195,7 @@ show_temp(struct device *dev, struct dev
 }

 static ssize_t
-show_temp_min(struct device *dev, struct device_attribute *da, char *buf)
+temp_min_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	int nr = to_sensor_dev_attr(da)->index;
 	struct emc2103_data *data = emc2103_update_device(dev);
@@ -204,7 +204,7 @@ show_temp_min(struct device *dev, struct
 }

 static ssize_t
-show_temp_max(struct device *dev, struct device_attribute *da, char *buf)
+temp_max_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	int nr = to_sensor_dev_attr(da)->index;
 	struct emc2103_data *data = emc2103_update_device(dev);
@@ -213,7 +213,7 @@ show_temp_max(struct device *dev, struct
 }

 static ssize_t
-show_temp_fault(struct device *dev, struct device_attribute *da, char *buf)
+temp_fault_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	int nr = to_sensor_dev_attr(da)->index;
 	struct emc2103_data *data = emc2103_update_device(dev);
@@ -222,7 +222,7 @@ show_temp_fault(struct device *dev, stru
 }

 static ssize_t
-show_temp_min_alarm(struct device *dev, struct device_attribute *da, char *buf)
+temp_min_alarm_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	int nr = to_sensor_dev_attr(da)->index;
 	struct emc2103_data *data = emc2103_update_device(dev);
@@ -231,7 +231,7 @@ show_temp_min_alarm(struct device *dev,
 }

 static ssize_t
-show_temp_max_alarm(struct device *dev, struct device_attribute *da, char *buf)
+temp_max_alarm_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	int nr = to_sensor_dev_attr(da)->index;
 	struct emc2103_data *data = emc2103_update_device(dev);
@@ -239,8 +239,8 @@ show_temp_max_alarm(struct device *dev,
 	return sprintf(buf, "%d\n", alarm ? 1 : 0);
 }

-static ssize_t set_temp_min(struct device *dev, struct device_attribute *da,
-			    const char *buf, size_t count)
+static ssize_t temp_min_store(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(da)->index;
 	struct emc2103_data *data = dev_get_drvdata(dev);
@@ -261,8 +261,8 @@ static ssize_t set_temp_min(struct devic
 	return count;
 }

-static ssize_t set_temp_max(struct device *dev, struct device_attribute *da,
-			    const char *buf, size_t count)
+static ssize_t temp_max_store(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
 {
 	int nr = to_sensor_dev_attr(da)->index;
 	struct emc2103_data *data = dev_get_drvdata(dev);
@@ -468,49 +468,33 @@ err:
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR, show_temp_min,
-	set_temp_min, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp_max,
-	set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_temp_min_alarm,
-	NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_temp_max_alarm,
-	NULL, 0);
-
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO | S_IWUSR, show_temp_min,
-	set_temp_min, 1);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR, show_temp_max,
-	set_temp_max, 1);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_temp_min_alarm,
-	NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_temp_max_alarm,
-	NULL, 1);
-
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO | S_IWUSR, show_temp_min,
-	set_temp_min, 2);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR, show_temp_max,
-	set_temp_max, 2);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO, show_temp_min_alarm,
-	NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_temp_max_alarm,
-	NULL, 2);
-
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO | S_IWUSR, show_temp_min,
-	set_temp_min, 3);
-static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO | S_IWUSR, show_temp_max,
-	set_temp_max, 3);
-static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_temp_fault, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO, show_temp_min_alarm,
-	NULL, 3);
-static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_temp_max_alarm,
-	NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp_min, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_fault, temp_fault, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, temp_min_alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, temp_max_alarm, 0);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_min, temp_min, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp_fault, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, temp_min_alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, temp_max_alarm, 1);
+
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
+static SENSOR_DEVICE_ATTR_RW(temp3_min, temp_min, 2);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, temp_max, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, temp_fault, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_min_alarm, temp_min_alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, temp_max_alarm, 2);
+
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 3);
+static SENSOR_DEVICE_ATTR_RW(temp4_min, temp_min, 3);
+static SENSOR_DEVICE_ATTR_RW(temp4_max, temp_max, 3);
+static SENSOR_DEVICE_ATTR_RO(temp4_fault, temp_fault, 3);
+static SENSOR_DEVICE_ATTR_RO(temp4_min_alarm, temp_min_alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_alarm, temp_max_alarm, 3);

 static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL);
 static DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR, show_fan_div, set_fan_div);
diff -u -p a/drivers/hwmon/twl4030-madc-hwmon.c b/drivers/hwmon/twl4030-madc-hwmon.c
--- a/drivers/hwmon/twl4030-madc-hwmon.c
+++ b/drivers/hwmon/twl4030-madc-hwmon.c
@@ -40,8 +40,8 @@
 /*
  * sysfs hook function
  */
-static ssize_t madc_read(struct device *dev,
-			 struct device_attribute *devattr, char *buf)
+static ssize_t madc_read_show(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct twl4030_madc_request req = {
@@ -59,20 +59,20 @@ static ssize_t madc_read(struct device *
 }

 /* sysfs nodes to read individual channels from user side */
-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, madc_read, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, madc_read, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, madc_read, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, madc_read, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, madc_read, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, madc_read, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, madc_read, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, madc_read, NULL, 7);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, madc_read, NULL, 8);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, madc_read, NULL, 9);
-static SENSOR_DEVICE_ATTR(curr10_input, S_IRUGO, madc_read, NULL, 10);
-static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, madc_read, NULL, 11);
-static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, madc_read, NULL, 12);
-static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, madc_read, NULL, 15);
+static SENSOR_DEVICE_ATTR_RO(in0_input, madc_read, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, madc_read, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, madc_read, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, madc_read, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, madc_read, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_input, madc_read, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_input, madc_read, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_input, madc_read, 7);
+static SENSOR_DEVICE_ATTR_RO(in8_input, madc_read, 8);
+static SENSOR_DEVICE_ATTR_RO(in9_input, madc_read, 9);
+static SENSOR_DEVICE_ATTR_RO(curr10_input, madc_read, 10);
+static SENSOR_DEVICE_ATTR_RO(in11_input, madc_read, 11);
+static SENSOR_DEVICE_ATTR_RO(in12_input, madc_read, 12);
+static SENSOR_DEVICE_ATTR_RO(in15_input, madc_read, 15);

 static struct attribute *twl4030_madc_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -323,7 +323,7 @@ show_fan_reg(fan);
 show_fan_reg(fan_min);

 static ssize_t
-store_fan_min(struct device *dev, struct device_attribute *da,
+fan_min_store(struct device *dev, struct device_attribute *da,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -348,13 +348,13 @@ store_fan_min(struct device *dev, struct

 static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
 static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO | S_IWUSR,
-		show_fan_min, store_fan_min, 0);
+		show_fan_min, fan_min_store, 0);
 static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
 static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO | S_IWUSR,
-		show_fan_min, store_fan_min, 1);
+		show_fan_min, fan_min_store, 1);
 static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
 static SENSOR_DEVICE_ATTR(fan3_min, S_IRUGO | S_IWUSR,
-		show_fan_min, store_fan_min, 2);
+		show_fan_min, fan_min_store, 2);

 #define show_temp_reg(reg) \
 static ssize_t show_##reg(struct device *dev, struct device_attribute *da, \
@@ -458,7 +458,7 @@ show_alarms_reg(struct device *dev, stru

 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
@@ -467,7 +467,7 @@ static ssize_t show_alarm(struct device
 }

 /* The W83781D has a single alarm bit for temp2 and temp3 */
-static ssize_t show_temp3_alarm(struct device *dev,
+static ssize_t temp3_alarm_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
@@ -475,21 +475,21 @@ static ssize_t show_temp3_alarm(struct d
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 16);
-static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 17);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_temp3_alarm, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, alarm, 16);
+static SENSOR_DEVICE_ATTR_RO(in8_alarm, alarm, 17);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, temp3_alarm, 0);

 static ssize_t show_beep_mask(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -530,7 +530,7 @@ store_beep_mask(struct device *dev, stru
 static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR,
 		show_beep_mask, store_beep_mask);

-static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
+static ssize_t beep_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
@@ -539,7 +539,7 @@ static ssize_t show_beep(struct device *
 }

 static ssize_t
-store_beep(struct device *dev, struct device_attribute *attr,
+beep_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
@@ -597,41 +597,26 @@ static ssize_t show_temp3_beep(struct de
 	return sprintf(buf, "%u\n", (data->beep_mask >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(in0_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 0);
-static SENSOR_DEVICE_ATTR(in1_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 1);
-static SENSOR_DEVICE_ATTR(in2_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 2);
-static SENSOR_DEVICE_ATTR(in3_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 3);
-static SENSOR_DEVICE_ATTR(in4_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 8);
-static SENSOR_DEVICE_ATTR(in5_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 9);
-static SENSOR_DEVICE_ATTR(in6_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 10);
-static SENSOR_DEVICE_ATTR(in7_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 16);
-static SENSOR_DEVICE_ATTR(in8_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 17);
-static SENSOR_DEVICE_ATTR(fan1_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 6);
-static SENSOR_DEVICE_ATTR(fan2_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 7);
-static SENSOR_DEVICE_ATTR(fan3_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 11);
-static SENSOR_DEVICE_ATTR(temp1_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 4);
-static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 5);
+static SENSOR_DEVICE_ATTR_RW(in0_beep, beep, 0);
+static SENSOR_DEVICE_ATTR_RW(in1_beep, beep, 1);
+static SENSOR_DEVICE_ATTR_RW(in2_beep, beep, 2);
+static SENSOR_DEVICE_ATTR_RW(in3_beep, beep, 3);
+static SENSOR_DEVICE_ATTR_RW(in4_beep, beep, 8);
+static SENSOR_DEVICE_ATTR_RW(in5_beep, beep, 9);
+static SENSOR_DEVICE_ATTR_RW(in6_beep, beep, 10);
+static SENSOR_DEVICE_ATTR_RW(in7_beep, beep, 16);
+static SENSOR_DEVICE_ATTR_RW(in8_beep, beep, 17);
+static SENSOR_DEVICE_ATTR_RW(fan1_beep, beep, 6);
+static SENSOR_DEVICE_ATTR_RW(fan2_beep, beep, 7);
+static SENSOR_DEVICE_ATTR_RW(fan3_beep, beep, 11);
+static SENSOR_DEVICE_ATTR_RW(temp1_beep, beep, 4);
+static SENSOR_DEVICE_ATTR_RW(temp2_beep, beep, 5);
 static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO,
-			show_temp3_beep, store_beep, 13);
-static SENSOR_DEVICE_ATTR(beep_enable, S_IRUGO | S_IWUSR,
-			show_beep, store_beep, 15);
+			show_temp3_beep, beep_store, 13);
+static SENSOR_DEVICE_ATTR_RW(beep_enable, beep, 15);

 static ssize_t
-show_fan_div(struct device *dev, struct device_attribute *da, char *buf)
+fan_div_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = w83781d_update_device(dev);
@@ -646,7 +631,7 @@ show_fan_div(struct device *dev, struct
  * because the divisor changed.
  */
 static ssize_t
-store_fan_div(struct device *dev, struct device_attribute *da,
+fan_div_store(struct device *dev, struct device_attribute *da,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -692,15 +677,12 @@ store_fan_div(struct device *dev, struct
 	return count;
 }

-static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
-		show_fan_div, store_fan_div, 0);
-static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
-		show_fan_div, store_fan_div, 1);
-static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO | S_IWUSR,
-		show_fan_div, store_fan_div, 2);
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_div, fan_div, 2);

 static ssize_t
-show_pwm(struct device *dev, struct device_attribute *da, char *buf)
+pwm_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = w83781d_update_device(dev);
@@ -715,7 +697,7 @@ show_pwm2_enable(struct device *dev, str
 }

 static ssize_t
-store_pwm(struct device *dev, struct device_attribute *da, const char *buf,
+pwm_store(struct device *dev, struct device_attribute *da, const char *buf,
 		size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -773,16 +755,16 @@ store_pwm2_enable(struct device *dev, st
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 1);
-static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 2);
-static SENSOR_DEVICE_ATTR(pwm4, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 3);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4, pwm, 3);
 /* only PWM2 can be enabled/disabled */
 static DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR,
 		show_pwm2_enable, store_pwm2_enable);

 static ssize_t
-show_sensor(struct device *dev, struct device_attribute *da, char *buf)
+sensor_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct w83781d_data *data = w83781d_update_device(dev);
@@ -790,7 +772,7 @@ show_sensor(struct device *dev, struct d
 }

 static ssize_t
-store_sensor(struct device *dev, struct device_attribute *da,
+sensor_store(struct device *dev, struct device_attribute *da,
 		const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -846,12 +828,9 @@ store_sensor(struct device *dev, struct
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO | S_IWUSR,
-	show_sensor, store_sensor, 0);
-static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO | S_IWUSR,
-	show_sensor, store_sensor, 1);
-static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO | S_IWUSR,
-	show_sensor, store_sensor, 2);
+static SENSOR_DEVICE_ATTR_RW(temp1_type, sensor, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_type, sensor, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_type, sensor, 2);

 /*
  * Assumes that adapter is of I2C, not ISA variety.
diff -u -p a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -230,7 +230,7 @@ static int ADT7X10_REG_TO_TEMP(struct ad

 /* sysfs attributes for hwmon */

-static ssize_t adt7x10_show_temp(struct device *dev,
+static ssize_t adt7x10_temp_show(struct device *dev,
 				 struct device_attribute *da,
 				 char *buf)
 {
@@ -250,9 +250,9 @@ static ssize_t adt7x10_show_temp(struct
 		       data->temp[attr->index]));
 }

-static ssize_t adt7x10_set_temp(struct device *dev,
-				struct device_attribute *da,
-				const char *buf, size_t count)
+static ssize_t adt7x10_temp_store(struct device *dev,
+				  struct device_attribute *da,
+				  const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct adt7x10_data *data = dev_get_drvdata(dev);
@@ -273,7 +273,7 @@ static ssize_t adt7x10_set_temp(struct d
 	return count;
 }

-static ssize_t adt7x10_show_t_hyst(struct device *dev,
+static ssize_t adt7x10_t_hyst_show(struct device *dev,
 				   struct device_attribute *da,
 				   char *buf)
 {
@@ -294,9 +294,9 @@ static ssize_t adt7x10_show_t_hyst(struc
 		       ADT7X10_REG_TO_TEMP(data, data->temp[nr]) - hyst);
 }

-static ssize_t adt7x10_set_t_hyst(struct device *dev,
-				  struct device_attribute *da,
-				  const char *buf, size_t count)
+static ssize_t adt7x10_t_hyst_store(struct device *dev,
+				    struct device_attribute *da,
+				    const char *buf, size_t count)
 {
 	struct adt7x10_data *data = dev_get_drvdata(dev);
 	int limit, ret;
@@ -317,7 +317,7 @@ static ssize_t adt7x10_set_t_hyst(struct
 	return count;
 }

-static ssize_t adt7x10_show_alarm(struct device *dev,
+static ssize_t adt7x10_alarm_show(struct device *dev,
 				  struct device_attribute *da,
 				  char *buf)
 {
@@ -340,25 +340,19 @@ static ssize_t adt7x10_show_name(struct
 	return sprintf(buf, "%s\n", data->name);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, adt7x10_show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
-			  adt7x10_show_temp, adt7x10_set_temp, 1);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
-			  adt7x10_show_temp, adt7x10_set_temp, 2);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO,
-			  adt7x10_show_temp, adt7x10_set_temp, 3);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
-			  adt7x10_show_t_hyst, adt7x10_set_t_hyst, 1);
-static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO,
-			  adt7x10_show_t_hyst, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO,
-			  adt7x10_show_t_hyst, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, adt7x10_show_alarm,
-			  NULL, ADT7X10_STAT_T_LOW);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, adt7x10_show_alarm,
-			  NULL, ADT7X10_STAT_T_HIGH);
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, adt7x10_show_alarm,
-			  NULL, ADT7X10_STAT_T_CRIT);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, adt7x10_temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, adt7x10_temp, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, adt7x10_temp, 2);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit, adt7x10_temp, 3);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, adt7x10_t_hyst, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_hyst, adt7x10_t_hyst, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_hyst, adt7x10_t_hyst, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, adt7x10_alarm,
+			     ADT7X10_STAT_T_LOW);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, adt7x10_alarm,
+			     ADT7X10_STAT_T_HIGH);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, adt7x10_alarm,
+			     ADT7X10_STAT_T_CRIT);
 static DEVICE_ATTR(name, S_IRUGO, adt7x10_show_name, NULL);

 static struct attribute *adt7x10_attributes[] = {
diff -u -p a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -319,7 +319,7 @@ static int find_nearest(long val, const
 	return 0;
 }

-static ssize_t show_voltage(struct device *dev, struct device_attribute *attr,
+static ssize_t voltage_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
@@ -337,8 +337,9 @@ static ssize_t show_voltage(struct devic
 	}
 }

-static ssize_t set_voltage(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t voltage_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {

 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -374,7 +375,7 @@ static ssize_t set_voltage(struct device
 	return count;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
@@ -429,8 +430,8 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", out);
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	struct i2c_client *client = to_i2c_client(dev);
@@ -536,7 +537,7 @@ static const int autorange_table[] = {
 	53330, 80000
 };

-static ssize_t show_point2(struct device *dev, struct device_attribute *attr,
+static ssize_t point2_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
@@ -551,8 +552,8 @@ static ssize_t show_point2(struct device
 	return sprintf(buf, "%d\n", val + autorange_table[out]);
 }

-static ssize_t set_point2(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
+static ssize_t point2_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7475_data *data = i2c_get_clientdata(client);
@@ -594,7 +595,7 @@ static ssize_t set_point2(struct device
 	return count;
 }

-static ssize_t show_tach(struct device *dev, struct device_attribute *attr,
+static ssize_t tach_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
@@ -609,8 +610,8 @@ static ssize_t show_tach(struct device *
 	return sprintf(buf, "%d\n", out);
 }

-static ssize_t set_tach(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t tach_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {

 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -632,7 +633,7 @@ static ssize_t set_tach(struct device *d
 	return count;
 }

-static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
@@ -641,7 +642,7 @@ static ssize_t show_pwm(struct device *d
 	return sprintf(buf, "%d\n", data->pwm[sattr->nr][sattr->index]);
 }

-static ssize_t show_pwmchan(struct device *dev, struct device_attribute *attr,
+static ssize_t pwmchan_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
@@ -650,7 +651,7 @@ static ssize_t show_pwmchan(struct devic
 	return sprintf(buf, "%d\n", data->pwmchan[sattr->index]);
 }

-static ssize_t show_pwmctrl(struct device *dev, struct device_attribute *attr,
+static ssize_t pwmctrl_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
@@ -659,8 +660,8 @@ static ssize_t show_pwmctrl(struct devic
 	return sprintf(buf, "%d\n", data->pwmctl[sattr->index]);
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {

 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -767,8 +768,9 @@ static int hw_set_pwm(struct i2c_client
 	return 0;
 }

-static ssize_t set_pwmchan(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t pwmchan_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	struct i2c_client *client = to_i2c_client(dev);
@@ -790,8 +792,9 @@ static ssize_t set_pwmchan(struct device
 	return count;
 }

-static ssize_t set_pwmctrl(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t pwmctrl_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	struct i2c_client *client = to_i2c_client(dev);
@@ -818,7 +821,7 @@ static const int pwmfreq_table[] = {
 	11, 14, 22, 29, 35, 44, 58, 88
 };

-static ssize_t show_pwmfreq(struct device *dev, struct device_attribute *attr,
+static ssize_t pwmfreq_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
@@ -828,8 +831,9 @@ static ssize_t show_pwmfreq(struct devic
 		       pwmfreq_table[data->range[sattr->index] & 7]);
 }

-static ssize_t set_pwmfreq(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t pwmfreq_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
 	struct i2c_client *client = to_i2c_client(dev);
@@ -917,144 +921,89 @@ static ssize_t show_vid(struct device *d
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }

-static SENSOR_DEVICE_ATTR_2(in0_input, S_IRUGO, show_voltage, NULL, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(in0_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 0);
-static SENSOR_DEVICE_ATTR_2(in0_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 0);
-static SENSOR_DEVICE_ATTR_2(in0_alarm, S_IRUGO, show_voltage, NULL, ALARM, 0);
-static SENSOR_DEVICE_ATTR_2(in1_input, S_IRUGO, show_voltage, NULL, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(in1_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 1);
-static SENSOR_DEVICE_ATTR_2(in1_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 1);
-static SENSOR_DEVICE_ATTR_2(in1_alarm, S_IRUGO, show_voltage, NULL, ALARM, 1);
-static SENSOR_DEVICE_ATTR_2(in2_input, S_IRUGO, show_voltage, NULL, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(in2_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 2);
-static SENSOR_DEVICE_ATTR_2(in2_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 2);
-static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, show_voltage, NULL, ALARM, 2);
-static SENSOR_DEVICE_ATTR_2(in3_input, S_IRUGO, show_voltage, NULL, INPUT, 3);
-static SENSOR_DEVICE_ATTR_2(in3_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 3);
-static SENSOR_DEVICE_ATTR_2(in3_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 3);
-static SENSOR_DEVICE_ATTR_2(in3_alarm, S_IRUGO, show_voltage, NULL, ALARM, 3);
-static SENSOR_DEVICE_ATTR_2(in4_input, S_IRUGO, show_voltage, NULL, INPUT, 4);
-static SENSOR_DEVICE_ATTR_2(in4_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 4);
-static SENSOR_DEVICE_ATTR_2(in4_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 4);
-static SENSOR_DEVICE_ATTR_2(in4_alarm, S_IRUGO, show_voltage, NULL, ALARM, 8);
-static SENSOR_DEVICE_ATTR_2(in5_input, S_IRUGO, show_voltage, NULL, INPUT, 5);
-static SENSOR_DEVICE_ATTR_2(in5_max, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MAX, 5);
-static SENSOR_DEVICE_ATTR_2(in5_min, S_IRUGO | S_IWUSR, show_voltage,
-			    set_voltage, MIN, 5);
-static SENSOR_DEVICE_ATTR_2(in5_alarm, S_IRUGO, show_voltage, NULL, ALARM, 31);
-static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_alarm, S_IRUGO, show_temp, NULL, ALARM, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_fault, S_IRUGO, show_temp, NULL, FAULT, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MAX, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MIN, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_offset, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, OFFSET, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, set_temp, AUTOMIN, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_point2, set_point2, 0, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    THERM, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_crit_hyst, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, HYSTERSIS, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_alarm, S_IRUGO, show_temp, NULL, ALARM, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MAX, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MIN, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_offset, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, OFFSET, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, set_temp, AUTOMIN, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_point2, set_point2, 0, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    THERM, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_crit_hyst, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, HYSTERSIS, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_alarm, S_IRUGO, show_temp, NULL, ALARM, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_fault, S_IRUGO, show_temp, NULL, FAULT, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MAX, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_min, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    MIN, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_offset, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, OFFSET, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_temp, set_temp, AUTOMIN, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_point2, set_point2, 0, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    THERM, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_crit_hyst, S_IRUGO | S_IWUSR, show_temp,
-			    set_temp, HYSTERSIS, 2);
-static SENSOR_DEVICE_ATTR_2(fan1_input, S_IRUGO, show_tach, NULL, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(fan1_min, S_IRUGO | S_IWUSR, show_tach, set_tach,
-			    MIN, 0);
-static SENSOR_DEVICE_ATTR_2(fan1_alarm, S_IRUGO, show_tach, NULL, ALARM, 0);
-static SENSOR_DEVICE_ATTR_2(fan2_input, S_IRUGO, show_tach, NULL, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(fan2_min, S_IRUGO | S_IWUSR, show_tach, set_tach,
-			    MIN, 1);
-static SENSOR_DEVICE_ATTR_2(fan2_alarm, S_IRUGO, show_tach, NULL, ALARM, 1);
-static SENSOR_DEVICE_ATTR_2(fan3_input, S_IRUGO, show_tach, NULL, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(fan3_min, S_IRUGO | S_IWUSR, show_tach, set_tach,
-			    MIN, 2);
-static SENSOR_DEVICE_ATTR_2(fan3_alarm, S_IRUGO, show_tach, NULL, ALARM, 2);
-static SENSOR_DEVICE_ATTR_2(fan4_input, S_IRUGO, show_tach, NULL, INPUT, 3);
-static SENSOR_DEVICE_ATTR_2(fan4_min, S_IRUGO | S_IWUSR, show_tach, set_tach,
-			    MIN, 3);
-static SENSOR_DEVICE_ATTR_2(fan4_alarm, S_IRUGO, show_tach, NULL, ALARM, 3);
-static SENSOR_DEVICE_ATTR_2(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm, INPUT,
-			    0);
-static SENSOR_DEVICE_ATTR_2(pwm1_freq, S_IRUGO | S_IWUSR, show_pwmfreq,
-			    set_pwmfreq, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_enable, S_IRUGO | S_IWUSR, show_pwmctrl,
-			    set_pwmctrl, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_channels_temp, S_IRUGO | S_IWUSR,
-			    show_pwmchan, set_pwmchan, INPUT, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MIN, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MAX, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2, S_IRUGO | S_IWUSR, show_pwm, set_pwm, INPUT,
-			    1);
-static SENSOR_DEVICE_ATTR_2(pwm2_freq, S_IRUGO | S_IWUSR, show_pwmfreq,
-			    set_pwmfreq, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_enable, S_IRUGO | S_IWUSR, show_pwmctrl,
-			    set_pwmctrl, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_channels_temp, S_IRUGO | S_IWUSR,
-			    show_pwmchan, set_pwmchan, INPUT, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MIN, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MAX, 1);
-static SENSOR_DEVICE_ATTR_2(pwm3, S_IRUGO | S_IWUSR, show_pwm, set_pwm, INPUT,
-			    2);
-static SENSOR_DEVICE_ATTR_2(pwm3_freq, S_IRUGO | S_IWUSR, show_pwmfreq,
-			    set_pwmfreq, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_enable, S_IRUGO | S_IWUSR, show_pwmctrl,
-			    set_pwmctrl, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_channels_temp, S_IRUGO | S_IWUSR,
-			    show_pwmchan, set_pwmchan, INPUT, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MIN, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO | S_IWUSR, show_pwm,
-			    set_pwm, MAX, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in0_input, voltage, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in0_max, voltage, MAX, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in0_min, voltage, MIN, 0);
+static SENSOR_DEVICE_ATTR_2_RO(in0_alarm, voltage, ALARM, 0);
+static SENSOR_DEVICE_ATTR_2_RO(in1_input, voltage, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in1_max, voltage, MAX, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in1_min, voltage, MIN, 1);
+static SENSOR_DEVICE_ATTR_2_RO(in1_alarm, voltage, ALARM, 1);
+static SENSOR_DEVICE_ATTR_2_RO(in2_input, voltage, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2_RW(in2_max, voltage, MAX, 2);
+static SENSOR_DEVICE_ATTR_2_RW(in2_min, voltage, MIN, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in2_alarm, voltage, ALARM, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in3_input, voltage, INPUT, 3);
+static SENSOR_DEVICE_ATTR_2_RW(in3_max, voltage, MAX, 3);
+static SENSOR_DEVICE_ATTR_2_RW(in3_min, voltage, MIN, 3);
+static SENSOR_DEVICE_ATTR_2_RO(in3_alarm, voltage, ALARM, 3);
+static SENSOR_DEVICE_ATTR_2_RO(in4_input, voltage, INPUT, 4);
+static SENSOR_DEVICE_ATTR_2_RW(in4_max, voltage, MAX, 4);
+static SENSOR_DEVICE_ATTR_2_RW(in4_min, voltage, MIN, 4);
+static SENSOR_DEVICE_ATTR_2_RO(in4_alarm, voltage, ALARM, 8);
+static SENSOR_DEVICE_ATTR_2_RO(in5_input, voltage, INPUT, 5);
+static SENSOR_DEVICE_ATTR_2_RW(in5_max, voltage, MAX, 5);
+static SENSOR_DEVICE_ATTR_2_RW(in5_min, voltage, MIN, 5);
+static SENSOR_DEVICE_ATTR_2_RO(in5_alarm, voltage, ALARM, 31);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_alarm, temp, ALARM, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_fault, temp, FAULT, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, MAX, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_min, temp, MIN, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_offset, temp, OFFSET, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_point1_temp, temp, AUTOMIN, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_point2_temp, point2, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, THERM, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_crit_hyst, temp, HYSTERSIS, 0);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_alarm, temp, ALARM, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp, MAX, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_min, temp, MIN, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_offset, temp, OFFSET, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_point1_temp, temp, AUTOMIN, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_point2_temp, point2, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_crit, temp, THERM, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_crit_hyst, temp, HYSTERSIS, 1);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_alarm, temp, ALARM, 2);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_fault, temp, FAULT, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp, MAX, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_min, temp, MIN, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_offset, temp, OFFSET, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_point1_temp, temp, AUTOMIN, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_point2_temp, point2, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_crit, temp, THERM, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_crit_hyst, temp, HYSTERSIS, 2);
+static SENSOR_DEVICE_ATTR_2_RO(fan1_input, tach, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2_RW(fan1_min, tach, MIN, 0);
+static SENSOR_DEVICE_ATTR_2_RO(fan1_alarm, tach, ALARM, 0);
+static SENSOR_DEVICE_ATTR_2_RO(fan2_input, tach, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2_RW(fan2_min, tach, MIN, 1);
+static SENSOR_DEVICE_ATTR_2_RO(fan2_alarm, tach, ALARM, 1);
+static SENSOR_DEVICE_ATTR_2_RO(fan3_input, tach, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2_RW(fan3_min, tach, MIN, 2);
+static SENSOR_DEVICE_ATTR_2_RO(fan3_alarm, tach, ALARM, 2);
+static SENSOR_DEVICE_ATTR_2_RO(fan4_input, tach, INPUT, 3);
+static SENSOR_DEVICE_ATTR_2_RW(fan4_min, tach, MIN, 3);
+static SENSOR_DEVICE_ATTR_2_RO(fan4_alarm, tach, ALARM, 3);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1, pwm, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_freq, pwmfreq, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_enable, pwmctrl, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_channels_temp, pwmchan, INPUT, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_pwm, pwm, MIN, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_pwm, pwm, MAX, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2, pwm, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_freq, pwmfreq, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_enable, pwmctrl, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_channels_temp, pwmchan, INPUT, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_pwm, pwm, MIN, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_pwm, pwm, MAX, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3, pwm, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_freq, pwmfreq, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_enable, pwmctrl, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_channels_temp, pwmchan, INPUT, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_pwm, pwm, MIN, 2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_pwm, pwm, MAX, 2);

 /* Non-standard name, might need revisiting */
 static DEVICE_ATTR(pwm_use_point2_pwm_at_crit, S_IWUSR | S_IRUGO,
diff -u -p a/drivers/hwmon/ads7828.c b/drivers/hwmon/ads7828.c
--- a/drivers/hwmon/ads7828.c
+++ b/drivers/hwmon/ads7828.c
@@ -60,7 +60,7 @@ static inline u8 ads7828_cmd_byte(u8 cmd
 }

 /* sysfs callback function */
-static ssize_t ads7828_show_in(struct device *dev, struct device_attribute *da,
+static ssize_t ads7828_in_show(struct device *dev, struct device_attribute *da,
 			       char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -77,14 +77,14 @@ static ssize_t ads7828_show_in(struct de
 		       DIV_ROUND_CLOSEST(regval * data->lsb_resol, 1000));
 }

-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ads7828_show_in, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ads7828_show_in, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ads7828_show_in, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, ads7828_show_in, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, ads7828_show_in, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, ads7828_show_in, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, ads7828_show_in, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, ads7828_show_in, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(in0_input, ads7828_in, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ads7828_in, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, ads7828_in, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, ads7828_in, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, ads7828_in, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_input, ads7828_in, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_input, ads7828_in, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_input, ads7828_in, 7);

 static struct attribute *ads7828_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -107,15 +107,15 @@ static struct ad7414_data *ad7414_update
 	return data;
 }

-static ssize_t show_temp_input(struct device *dev,
+static ssize_t temp_input_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct ad7414_data *data = ad7414_update_device(dev);
 	return sprintf(buf, "%d\n", ad7414_temp_from_reg(data->temp_input));
 }
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);

-static ssize_t show_max_min(struct device *dev, struct device_attribute *attr,
+static ssize_t max_min_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int index = to_sensor_dev_attr(attr)->index;
@@ -123,9 +123,9 @@ static ssize_t show_max_min(struct devic
 	return sprintf(buf, "%d\n", data->temps[index] * 1000);
 }

-static ssize_t set_max_min(struct device *dev,
-			   struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t max_min_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct ad7414_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -147,12 +147,10 @@ static ssize_t set_max_min(struct device
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
-			  show_max_min, set_max_min, 0);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
-			  show_max_min, set_max_min, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, max_min, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, max_min, 1);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
@@ -161,8 +159,8 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%d\n", value);
 }

-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 4);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 4);

 static struct attribute *ad7414_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -287,7 +287,7 @@ static int ina2xx_get_value(struct ina2x
 	return val;
 }

-static ssize_t ina2xx_show_value(struct device *dev,
+static ssize_t ina2xx_value_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -330,9 +330,9 @@ static ssize_t ina2xx_set_shunt(struct d
 	return count;
 }

-static ssize_t ina226_set_interval(struct device *dev,
-				   struct device_attribute *da,
-				   const char *buf, size_t count)
+static ssize_t ina226_interval_store(struct device *dev,
+				     struct device_attribute *da,
+				     const char *buf, size_t count)
 {
 	struct ina2xx_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -354,7 +354,7 @@ static ssize_t ina226_set_interval(struc
 	return count;
 }

-static ssize_t ina226_show_interval(struct device *dev,
+static ssize_t ina226_interval_show(struct device *dev,
 				    struct device_attribute *da, char *buf)
 {
 	struct ina2xx_data *data = dev_get_drvdata(dev);
@@ -369,29 +369,24 @@ static ssize_t ina226_show_interval(stru
 }

 /* shunt voltage */
-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, ina2xx_show_value, NULL,
-			  INA2XX_SHUNT_VOLTAGE);
+static SENSOR_DEVICE_ATTR_RO(in0_input, ina2xx_value, INA2XX_SHUNT_VOLTAGE);

 /* bus voltage */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ina2xx_show_value, NULL,
-			  INA2XX_BUS_VOLTAGE);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ina2xx_value, INA2XX_BUS_VOLTAGE);

 /* calculated current */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ina2xx_show_value, NULL,
-			  INA2XX_CURRENT);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ina2xx_value, INA2XX_CURRENT);

 /* calculated power */
-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ina2xx_show_value, NULL,
-			  INA2XX_POWER);
+static SENSOR_DEVICE_ATTR_RO(power1_input, ina2xx_value, INA2XX_POWER);

 /* shunt resistance */
 static SENSOR_DEVICE_ATTR(shunt_resistor, S_IRUGO | S_IWUSR,
-			  ina2xx_show_value, ina2xx_set_shunt,
+			  ina2xx_value_show, ina2xx_set_shunt,
 			  INA2XX_CALIBRATION);

 /* update interval (ina226 only) */
-static SENSOR_DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR,
-			  ina226_show_interval, ina226_set_interval, 0);
+static SENSOR_DEVICE_ATTR_RW(update_interval, ina226_interval, 0);

 /* pointers to created device attributes */
 static struct attribute *ina2xx_attrs[] = {
diff -u -p a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -813,17 +813,17 @@ static void aem_bmc_gone(int iface)
 /* sysfs support functions */

 /* AEM device name */
-static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct aem_data *data = dev_get_drvdata(dev);

 	return sprintf(buf, "%s%d\n", DRVNAME, data->ver_major);
 }
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(name, name, 0);

 /* AEM device version */
-static ssize_t show_version(struct device *dev,
+static ssize_t version_show(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
@@ -831,7 +831,7 @@ static ssize_t show_version(struct devic

 	return sprintf(buf, "%d.%d\n", data->ver_major, data->ver_minor);
 }
-static SENSOR_DEVICE_ATTR(version, S_IRUGO, show_version, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(version, version, 0);

 /* Display power use */
 static ssize_t aem_show_power(struct device *dev,
diff -u -p a/drivers/hwmon/ad7418.c b/drivers/hwmon/ad7418.c
--- a/drivers/hwmon/ad7418.c
+++ b/drivers/hwmon/ad7418.c
@@ -103,7 +103,7 @@ static struct ad7418_data *ad7418_update
 	return data;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -112,7 +112,7 @@ static ssize_t show_temp(struct device *
 		LM75_TEMP_FROM_REG(data->temp[attr->index]));
 }

-static ssize_t show_adc(struct device *dev, struct device_attribute *devattr,
+static ssize_t adc_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -122,8 +122,9 @@ static ssize_t show_adc(struct device *d
 		((data->in[attr->index] >> 6) * 2500 + 512) / 1024);
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct ad7418_data *data = dev_get_drvdata(dev);
@@ -143,16 +144,14 @@ static ssize_t set_temp(struct device *d
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
-				show_temp, set_temp, 1);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
-				show_temp, set_temp, 2);
-
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_adc, NULL, 0);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_adc, NULL, 1);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_adc, NULL, 2);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_adc, NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, 2);
+
+static SENSOR_DEVICE_ATTR_RO(in1_input, adc, 0);
+static SENSOR_DEVICE_ATTR_RO(in2_input, adc, 1);
+static SENSOR_DEVICE_ATTR_RO(in3_input, adc, 2);
+static SENSOR_DEVICE_ATTR_RO(in4_input, adc, 3);

 static struct attribute *ad7416_attrs[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
diff -u -p a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -60,7 +60,7 @@ struct via_cputemp_data {
  * Sysfs stuff
  */

-static ssize_t show_name(struct device *dev, struct device_attribute
+static ssize_t name_show(struct device *dev, struct device_attribute
 			  *devattr, char *buf)
 {
 	int ret;
@@ -74,7 +74,7 @@ static ssize_t show_name(struct device *
 	return ret;
 }

-static ssize_t show_temp(struct device *dev,
+static ssize_t temp_show(struct device *dev,
 			 struct device_attribute *devattr, char *buf)
 {
 	struct via_cputemp_data *data = dev_get_drvdata(dev);
@@ -102,10 +102,9 @@ static ssize_t show_cpu_vid(struct devic
 	return sprintf(buf, "%d\n", vid_from_reg(~edx & 0x7f, data->vrm));
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL,
-			  SHOW_TEMP);
-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
-static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, SHOW_TEMP);
+static SENSOR_DEVICE_ATTR_RO(temp1_label, name, SHOW_LABEL);
+static SENSOR_DEVICE_ATTR_RO(name, name, SHOW_NAME);

 static struct attribute *via_cputemp_attributes[] = {
 	&sensor_dev_attr_name.dev_attr.attr,
diff -u -p a/drivers/hwmon/da9055-hwmon.c b/drivers/hwmon/da9055-hwmon.c
--- a/drivers/hwmon/da9055-hwmon.c
+++ b/drivers/hwmon/da9055-hwmon.c
@@ -140,8 +140,9 @@ static int da9055_disable_auto_mode(stru
 	return da9055_reg_update(da9055, DA9055_REG_ADC_CONT, 1 << channel, 0);
 }

-static ssize_t da9055_read_auto_ch(struct device *dev,
-				struct device_attribute *devattr, char *buf)
+static ssize_t da9055_read_auto_ch_show(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
 {
 	struct da9055_hwmon *hwmon = dev_get_drvdata(dev);
 	int ret, adc;
@@ -176,8 +177,9 @@ hwmon_err:
 	return ret;
 }

-static ssize_t da9055_read_tjunc(struct device *dev,
-				 struct device_attribute *devattr, char *buf)
+static ssize_t da9055_read_tjunc_show(struct device *dev,
+				      struct device_attribute *devattr,
+				      char *buf)
 {
 	struct da9055_hwmon *hwmon = dev_get_drvdata(dev);
 	int tjunc;
@@ -199,34 +201,27 @@ static ssize_t da9055_read_tjunc(struct
 							+ 3076332, 10000));
 }

-static ssize_t show_label(struct device *dev,
+static ssize_t label_show(struct device *dev,
 			  struct device_attribute *devattr, char *buf)
 {
 	return sprintf(buf, "%s\n",
 		       input_names[to_sensor_dev_attr(devattr)->index]);
 }

-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, da9055_read_auto_ch, NULL,
-			  DA9055_ADC_VSYS);
-static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, show_label, NULL,
-			  DA9055_ADC_VSYS);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, da9055_read_auto_ch, NULL,
-			  DA9055_ADC_ADCIN1);
-static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, show_label, NULL,
-			  DA9055_ADC_ADCIN1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, da9055_read_auto_ch, NULL,
-			  DA9055_ADC_ADCIN2);
-static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, show_label, NULL,
-			  DA9055_ADC_ADCIN2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, da9055_read_auto_ch, NULL,
-			  DA9055_ADC_ADCIN3);
-static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL,
-			  DA9055_ADC_ADCIN3);
-
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, da9055_read_tjunc, NULL,
-			  DA9055_ADC_TJUNC);
-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,
-			  DA9055_ADC_TJUNC);
+static SENSOR_DEVICE_ATTR_RO(in0_input, da9055_read_auto_ch, DA9055_ADC_VSYS);
+static SENSOR_DEVICE_ATTR_RO(in0_label, label, DA9055_ADC_VSYS);
+static SENSOR_DEVICE_ATTR_RO(in1_input, da9055_read_auto_ch,
+			     DA9055_ADC_ADCIN1);
+static SENSOR_DEVICE_ATTR_RO(in1_label, label, DA9055_ADC_ADCIN1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, da9055_read_auto_ch,
+			     DA9055_ADC_ADCIN2);
+static SENSOR_DEVICE_ATTR_RO(in2_label, label, DA9055_ADC_ADCIN2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, da9055_read_auto_ch,
+			     DA9055_ADC_ADCIN3);
+static SENSOR_DEVICE_ATTR_RO(in3_label, label, DA9055_ADC_ADCIN3);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, da9055_read_tjunc, DA9055_ADC_TJUNC);
+static SENSOR_DEVICE_ATTR_RO(temp1_label, label, DA9055_ADC_TJUNC);

 static struct attribute *da9055_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -659,7 +659,7 @@ static ssize_t show_alarms_reg(struct de

 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	int nr = to_sensor_dev_attr(attr)->index;
@@ -667,23 +667,23 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (data->alarms >> nr) & 1);
 }

-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 18);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 16);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 17);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_alarm, NULL, 14);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 15);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 13);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 18);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 16);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, alarm, 17);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp1_fault, alarm, 14);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 15);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(fan4_alarm, alarm, 13);

 /* pwm */

diff -u -p a/drivers/hwmon/hih6130.c b/drivers/hwmon/hih6130.c
--- a/drivers/hwmon/hih6130.c
+++ b/drivers/hwmon/hih6130.c
@@ -171,7 +171,7 @@ out:
  * Will be called on read access to temp1_input sysfs attribute.
  * Returns number of bytes written into buffer, negative errno on error.
  */
-static ssize_t hih6130_show_temperature(struct device *dev,
+static ssize_t hih6130_temperature_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
@@ -193,7 +193,7 @@ static ssize_t hih6130_show_temperature(
  * Will be called on read access to humidity1_input sysfs attribute.
  * Returns number of bytes written into buffer, negative errno on error.
  */
-static ssize_t hih6130_show_humidity(struct device *dev,
+static ssize_t hih6130_humidity_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
 	struct hih6130 *hih6130 = dev_get_drvdata(dev);
@@ -206,10 +206,8 @@ static ssize_t hih6130_show_humidity(str
 }

 /* sysfs attributes */
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, hih6130_show_temperature,
-	NULL, 0);
-static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO, hih6130_show_humidity,
-	NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, hih6130_temperature, 0);
+static SENSOR_DEVICE_ATTR_RO(humidity1_input, hih6130_humidity, 0);

 static struct attribute *hih6130_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -175,7 +175,7 @@ static struct max16065_data *max16065_up
 	return data;
 }

-static ssize_t max16065_show_alarm(struct device *dev,
+static ssize_t max16065_alarm_show(struct device *dev,
 				   struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(da);
@@ -193,7 +193,7 @@ static ssize_t max16065_show_alarm(struc
 	return snprintf(buf, PAGE_SIZE, "%d\n", !!val);
 }

-static ssize_t max16065_show_input(struct device *dev,
+static ssize_t max16065_input_show(struct device *dev,
 				   struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -207,7 +207,7 @@ static ssize_t max16065_show_input(struc
 			ADC_TO_MV(adc, data->range[attr->index]));
 }

-static ssize_t max16065_show_current(struct device *dev,
+static ssize_t max16065_current_show(struct device *dev,
 				     struct device_attribute *da, char *buf)
 {
 	struct max16065_data *data = max16065_update_device(dev);
@@ -219,9 +219,9 @@ static ssize_t max16065_show_current(str
 			ADC_TO_CURR(data->curr_sense, data->curr_gain));
 }

-static ssize_t max16065_set_limit(struct device *dev,
-				  struct device_attribute *da,
-				  const char *buf, size_t count)
+static ssize_t max16065_limit_store(struct device *dev,
+				    struct device_attribute *da,
+				    const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(da);
 	struct max16065_data *data = dev_get_drvdata(dev);
@@ -246,7 +246,7 @@ static ssize_t max16065_set_limit(struct
 	return count;
 }

-static ssize_t max16065_show_limit(struct device *dev,
+static ssize_t max16065_limit_show(struct device *dev,
 				   struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute_2 *attr2 = to_sensor_dev_attr_2(da);
@@ -259,154 +259,93 @@ static ssize_t max16065_show_limit(struc
 /* Construct a sensor_device_attribute structure for each register */

 /* Input voltages */
-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, max16065_show_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, max16065_show_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, max16065_show_input, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, max16065_show_input, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, max16065_show_input, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, max16065_show_input, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, max16065_show_input, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, max16065_show_input, NULL, 7);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, max16065_show_input, NULL, 8);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, max16065_show_input, NULL, 9);
-static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, max16065_show_input, NULL, 10);
-static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, max16065_show_input, NULL, 11);
-static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, max16065_show_input, NULL, 12);
+static SENSOR_DEVICE_ATTR_RO(in0_input, max16065_input, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_input, max16065_input, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, max16065_input, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, max16065_input, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, max16065_input, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_input, max16065_input, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_input, max16065_input, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_input, max16065_input, 7);
+static SENSOR_DEVICE_ATTR_RO(in8_input, max16065_input, 8);
+static SENSOR_DEVICE_ATTR_RO(in9_input, max16065_input, 9);
+static SENSOR_DEVICE_ATTR_RO(in10_input, max16065_input, 10);
+static SENSOR_DEVICE_ATTR_RO(in11_input, max16065_input, 11);
+static SENSOR_DEVICE_ATTR_RO(in12_input, max16065_input, 12);

 /* Input voltages lcrit */
-static SENSOR_DEVICE_ATTR_2(in0_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 0);
-static SENSOR_DEVICE_ATTR_2(in1_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 1);
-static SENSOR_DEVICE_ATTR_2(in2_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 2);
-static SENSOR_DEVICE_ATTR_2(in3_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 3);
-static SENSOR_DEVICE_ATTR_2(in4_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 4);
-static SENSOR_DEVICE_ATTR_2(in5_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 5);
-static SENSOR_DEVICE_ATTR_2(in6_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 6);
-static SENSOR_DEVICE_ATTR_2(in7_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 7);
-static SENSOR_DEVICE_ATTR_2(in8_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 8);
-static SENSOR_DEVICE_ATTR_2(in9_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 9);
-static SENSOR_DEVICE_ATTR_2(in10_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 10);
-static SENSOR_DEVICE_ATTR_2(in11_lcrit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 2, 11);
+static SENSOR_DEVICE_ATTR_2_RW(in0_lcrit, max16065_limit, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in1_lcrit, max16065_limit, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in2_lcrit, max16065_limit, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(in3_lcrit, max16065_limit, 2, 3);
+static SENSOR_DEVICE_ATTR_2_RW(in4_lcrit, max16065_limit, 2, 4);
+static SENSOR_DEVICE_ATTR_2_RW(in5_lcrit, max16065_limit, 2, 5);
+static SENSOR_DEVICE_ATTR_2_RW(in6_lcrit, max16065_limit, 2, 6);
+static SENSOR_DEVICE_ATTR_2_RW(in7_lcrit, max16065_limit, 2, 7);
+static SENSOR_DEVICE_ATTR_2_RW(in8_lcrit, max16065_limit, 2, 8);
+static SENSOR_DEVICE_ATTR_2_RW(in9_lcrit, max16065_limit, 2, 9);
+static SENSOR_DEVICE_ATTR_2_RW(in10_lcrit, max16065_limit, 2, 10);
+static SENSOR_DEVICE_ATTR_2_RW(in11_lcrit, max16065_limit, 2, 11);

 /* Input voltages crit */
-static SENSOR_DEVICE_ATTR_2(in0_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 0);
-static SENSOR_DEVICE_ATTR_2(in1_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 1);
-static SENSOR_DEVICE_ATTR_2(in2_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 2);
-static SENSOR_DEVICE_ATTR_2(in3_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 3);
-static SENSOR_DEVICE_ATTR_2(in4_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 4);
-static SENSOR_DEVICE_ATTR_2(in5_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 5);
-static SENSOR_DEVICE_ATTR_2(in6_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 6);
-static SENSOR_DEVICE_ATTR_2(in7_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 7);
-static SENSOR_DEVICE_ATTR_2(in8_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 8);
-static SENSOR_DEVICE_ATTR_2(in9_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 9);
-static SENSOR_DEVICE_ATTR_2(in10_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 10);
-static SENSOR_DEVICE_ATTR_2(in11_crit, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 1, 11);
+static SENSOR_DEVICE_ATTR_2_RW(in0_crit, max16065_limit, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in1_crit, max16065_limit, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in2_crit, max16065_limit, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RW(in3_crit, max16065_limit, 1, 3);
+static SENSOR_DEVICE_ATTR_2_RW(in4_crit, max16065_limit, 1, 4);
+static SENSOR_DEVICE_ATTR_2_RW(in5_crit, max16065_limit, 1, 5);
+static SENSOR_DEVICE_ATTR_2_RW(in6_crit, max16065_limit, 1, 6);
+static SENSOR_DEVICE_ATTR_2_RW(in7_crit, max16065_limit, 1, 7);
+static SENSOR_DEVICE_ATTR_2_RW(in8_crit, max16065_limit, 1, 8);
+static SENSOR_DEVICE_ATTR_2_RW(in9_crit, max16065_limit, 1, 9);
+static SENSOR_DEVICE_ATTR_2_RW(in10_crit, max16065_limit, 1, 10);
+static SENSOR_DEVICE_ATTR_2_RW(in11_crit, max16065_limit, 1, 11);

 /* Input voltages min */
-static SENSOR_DEVICE_ATTR_2(in0_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 0);
-static SENSOR_DEVICE_ATTR_2(in1_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 1);
-static SENSOR_DEVICE_ATTR_2(in2_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 2);
-static SENSOR_DEVICE_ATTR_2(in3_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 3);
-static SENSOR_DEVICE_ATTR_2(in4_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 4);
-static SENSOR_DEVICE_ATTR_2(in5_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 5);
-static SENSOR_DEVICE_ATTR_2(in6_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 6);
-static SENSOR_DEVICE_ATTR_2(in7_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 7);
-static SENSOR_DEVICE_ATTR_2(in8_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 8);
-static SENSOR_DEVICE_ATTR_2(in9_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 9);
-static SENSOR_DEVICE_ATTR_2(in10_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 10);
-static SENSOR_DEVICE_ATTR_2(in11_min, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 11);
+static SENSOR_DEVICE_ATTR_2_RW(in0_min, max16065_limit, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in1_min, max16065_limit, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in2_min, max16065_limit, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RW(in3_min, max16065_limit, 0, 3);
+static SENSOR_DEVICE_ATTR_2_RW(in4_min, max16065_limit, 0, 4);
+static SENSOR_DEVICE_ATTR_2_RW(in5_min, max16065_limit, 0, 5);
+static SENSOR_DEVICE_ATTR_2_RW(in6_min, max16065_limit, 0, 6);
+static SENSOR_DEVICE_ATTR_2_RW(in7_min, max16065_limit, 0, 7);
+static SENSOR_DEVICE_ATTR_2_RW(in8_min, max16065_limit, 0, 8);
+static SENSOR_DEVICE_ATTR_2_RW(in9_min, max16065_limit, 0, 9);
+static SENSOR_DEVICE_ATTR_2_RW(in10_min, max16065_limit, 0, 10);
+static SENSOR_DEVICE_ATTR_2_RW(in11_min, max16065_limit, 0, 11);

 /* Input voltages max */
-static SENSOR_DEVICE_ATTR_2(in0_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 0);
-static SENSOR_DEVICE_ATTR_2(in1_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 1);
-static SENSOR_DEVICE_ATTR_2(in2_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 2);
-static SENSOR_DEVICE_ATTR_2(in3_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 3);
-static SENSOR_DEVICE_ATTR_2(in4_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 4);
-static SENSOR_DEVICE_ATTR_2(in5_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 5);
-static SENSOR_DEVICE_ATTR_2(in6_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 6);
-static SENSOR_DEVICE_ATTR_2(in7_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 7);
-static SENSOR_DEVICE_ATTR_2(in8_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 8);
-static SENSOR_DEVICE_ATTR_2(in9_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 9);
-static SENSOR_DEVICE_ATTR_2(in10_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 10);
-static SENSOR_DEVICE_ATTR_2(in11_max, S_IWUSR | S_IRUGO, max16065_show_limit,
-			    max16065_set_limit, 0, 11);
+static SENSOR_DEVICE_ATTR_2_RW(in0_max, max16065_limit, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(in1_max, max16065_limit, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(in2_max, max16065_limit, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RW(in3_max, max16065_limit, 0, 3);
+static SENSOR_DEVICE_ATTR_2_RW(in4_max, max16065_limit, 0, 4);
+static SENSOR_DEVICE_ATTR_2_RW(in5_max, max16065_limit, 0, 5);
+static SENSOR_DEVICE_ATTR_2_RW(in6_max, max16065_limit, 0, 6);
+static SENSOR_DEVICE_ATTR_2_RW(in7_max, max16065_limit, 0, 7);
+static SENSOR_DEVICE_ATTR_2_RW(in8_max, max16065_limit, 0, 8);
+static SENSOR_DEVICE_ATTR_2_RW(in9_max, max16065_limit, 0, 9);
+static SENSOR_DEVICE_ATTR_2_RW(in10_max, max16065_limit, 0, 10);
+static SENSOR_DEVICE_ATTR_2_RW(in11_max, max16065_limit, 0, 11);

 /* alarms */
-static SENSOR_DEVICE_ATTR_2(in0_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    0, 0);
-static SENSOR_DEVICE_ATTR_2(in1_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    0, 1);
-static SENSOR_DEVICE_ATTR_2(in2_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    0, 2);
-static SENSOR_DEVICE_ATTR_2(in3_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    0, 3);
-static SENSOR_DEVICE_ATTR_2(in4_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    0, 4);
-static SENSOR_DEVICE_ATTR_2(in5_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    0, 5);
-static SENSOR_DEVICE_ATTR_2(in6_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    0, 6);
-static SENSOR_DEVICE_ATTR_2(in7_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    0, 7);
-static SENSOR_DEVICE_ATTR_2(in8_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    1, 0);
-static SENSOR_DEVICE_ATTR_2(in9_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    1, 1);
-static SENSOR_DEVICE_ATTR_2(in10_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    1, 2);
-static SENSOR_DEVICE_ATTR_2(in11_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    1, 3);
+static SENSOR_DEVICE_ATTR_2_RO(in0_alarm, max16065_alarm, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RO(in1_alarm, max16065_alarm, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RO(in2_alarm, max16065_alarm, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in3_alarm, max16065_alarm, 0, 3);
+static SENSOR_DEVICE_ATTR_2_RO(in4_alarm, max16065_alarm, 0, 4);
+static SENSOR_DEVICE_ATTR_2_RO(in5_alarm, max16065_alarm, 0, 5);
+static SENSOR_DEVICE_ATTR_2_RO(in6_alarm, max16065_alarm, 0, 6);
+static SENSOR_DEVICE_ATTR_2_RO(in7_alarm, max16065_alarm, 0, 7);
+static SENSOR_DEVICE_ATTR_2_RO(in8_alarm, max16065_alarm, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RO(in9_alarm, max16065_alarm, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RO(in10_alarm, max16065_alarm, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RO(in11_alarm, max16065_alarm, 1, 3);

 /* Current and alarm */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, max16065_show_current, NULL, 0);
-static SENSOR_DEVICE_ATTR_2(curr1_alarm, S_IRUGO, max16065_show_alarm, NULL,
-			    1, 4);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, max16065_current, 0);
+static SENSOR_DEVICE_ATTR_2_RO(curr1_alarm, max16065_alarm, 1, 4);

 /*
  * Finally, construct an array of pointers to members of the above objects,
diff -u -p a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -137,7 +137,7 @@ static struct lm77_data *lm77_update_dev

 /* sysfs stuff */

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -146,7 +146,7 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", data->temp[attr->index]);
 }

-static ssize_t show_temp_hyst(struct device *dev,
+static ssize_t temp_hyst_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -160,8 +160,9 @@ static ssize_t show_temp_hyst(struct dev
 	return sprintf(buf, "%d\n", temp);
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm77_data *data = dev_get_drvdata(dev);
@@ -186,9 +187,9 @@ static ssize_t set_temp(struct device *d
  * hysteresis is stored as a relative value on the chip, so it has to be
  * converted first.
  */
-static ssize_t set_temp_hyst(struct device *dev,
-			     struct device_attribute *devattr,
-			     const char *buf, size_t count)
+static ssize_t temp_hyst_store(struct device *dev,
+			       struct device_attribute *devattr,
+			       const char *buf, size_t count)
 {
 	struct lm77_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -208,7 +209,7 @@ static ssize_t set_temp_hyst(struct devi
 	return count;
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
@@ -216,22 +217,18 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, t_input);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp, set_temp,
-			  t_crit);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp,
-			  t_min);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp,
-			  t_max);
-
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_hyst,
-			  set_temp_hyst, t_crit);
-static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO, show_temp_hyst, NULL, t_min);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_temp_hyst, NULL, t_max);
-
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, t_input);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp, t_crit);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp, t_min);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, t_max);
+
+static SENSOR_DEVICE_ATTR_RW(temp1_crit_hyst, temp_hyst, t_crit);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_hyst, temp_hyst, t_min);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_hyst, temp_hyst, t_max);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 1);

 static struct attribute *lm77_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1699,7 +1699,7 @@ show_temp_alarm(struct device *dev, stru
 }

 static ssize_t
-show_beep(struct device *dev, struct device_attribute *attr, char *buf)
+beep_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sattr = to_sensor_dev_attr(attr);
 	struct nct6775_data *data = nct6775_update_device(dev);
@@ -1710,7 +1710,7 @@ show_beep(struct device *dev, struct dev
 }

 static ssize_t
-store_beep(struct device *dev, struct device_attribute *attr, const char *buf,
+beep_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	   size_t count)
 {
 	struct sensor_device_attribute_2 *sattr = to_sensor_dev_attr_2(attr);
@@ -1809,7 +1809,8 @@ static umode_t nct6775_in_is_visible(str

 SENSOR_TEMPLATE_2(in_input, "in%d_input", S_IRUGO, show_in_reg, NULL, 0, 0);
 SENSOR_TEMPLATE(in_alarm, "in%d_alarm", S_IRUGO, show_alarm, NULL, 0);
-SENSOR_TEMPLATE(in_beep, "in%d_beep", S_IWUSR | S_IRUGO, show_beep, store_beep,
+SENSOR_TEMPLATE(in_beep, "in%d_beep", S_IWUSR | S_IRUGO, beep_show,
+		beep_store,
 		0);
 SENSOR_TEMPLATE_2(in_min, "in%d_min", S_IWUSR | S_IRUGO, show_in_reg,
 		  store_in_reg, 0, 1);
@@ -2026,8 +2027,8 @@ static umode_t nct6775_fan_is_visible(st
 SENSOR_TEMPLATE(fan_input, "fan%d_input", S_IRUGO, show_fan, NULL, 0);
 SENSOR_TEMPLATE(fan_alarm, "fan%d_alarm", S_IRUGO, show_alarm, NULL,
 		FAN_ALARM_BASE);
-SENSOR_TEMPLATE(fan_beep, "fan%d_beep", S_IWUSR | S_IRUGO, show_beep,
-		store_beep, FAN_ALARM_BASE);
+SENSOR_TEMPLATE(fan_beep, "fan%d_beep", S_IWUSR | S_IRUGO, beep_show,
+		beep_store, FAN_ALARM_BASE);
 SENSOR_TEMPLATE(fan_pulses, "fan%d_pulses", S_IWUSR | S_IRUGO, show_fan_pulses,
 		store_fan_pulses, 0);
 SENSOR_TEMPLATE(fan_min, "fan%d_min", S_IWUSR | S_IRUGO, show_fan_min,
@@ -3182,12 +3183,9 @@ static SENSOR_DEVICE_ATTR(intrusion0_ala
 			  clear_caseopen, INTRUSION_ALARM_BASE);
 static SENSOR_DEVICE_ATTR(intrusion1_alarm, S_IWUSR | S_IRUGO, show_alarm,
 			  clear_caseopen, INTRUSION_ALARM_BASE + 1);
-static SENSOR_DEVICE_ATTR(intrusion0_beep, S_IWUSR | S_IRUGO, show_beep,
-			  store_beep, INTRUSION_ALARM_BASE);
-static SENSOR_DEVICE_ATTR(intrusion1_beep, S_IWUSR | S_IRUGO, show_beep,
-			  store_beep, INTRUSION_ALARM_BASE + 1);
-static SENSOR_DEVICE_ATTR(beep_enable, S_IWUSR | S_IRUGO, show_beep,
-			  store_beep, BEEP_ENABLE_BASE);
+static SENSOR_DEVICE_ATTR_RW(intrusion0_beep, beep, INTRUSION_ALARM_BASE);
+static SENSOR_DEVICE_ATTR_RW(intrusion1_beep, beep, INTRUSION_ALARM_BASE + 1);
+static SENSOR_DEVICE_ATTR_RW(beep_enable, beep, BEEP_ENABLE_BASE);

 static umode_t nct6775_other_is_visible(struct kobject *kobj,
 					struct attribute *attr, int index)
diff -u -p a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -1111,7 +1111,7 @@ static void lm93_update_client_min(struc
 }

 /* following are the sysfs callback functions */
-static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+static ssize_t in_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1120,24 +1120,24 @@ static ssize_t show_in(struct device *de
 	return sprintf(buf, "%d\n", LM93_IN_FROM_REG(nr, data->block3[nr]));
 }

-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 0);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 1);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 2);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in, NULL, 3);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in, NULL, 4);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in, NULL, 5);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_in, NULL, 6);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, show_in, NULL, 7);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, show_in, NULL, 8);
-static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, show_in, NULL, 9);
-static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, show_in, NULL, 10);
-static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, show_in, NULL, 11);
-static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, show_in, NULL, 12);
-static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, show_in, NULL, 13);
-static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, show_in, NULL, 14);
-static SENSOR_DEVICE_ATTR(in16_input, S_IRUGO, show_in, NULL, 15);
+static SENSOR_DEVICE_ATTR_RO(in1_input, in, 0);
+static SENSOR_DEVICE_ATTR_RO(in2_input, in, 1);
+static SENSOR_DEVICE_ATTR_RO(in3_input, in, 2);
+static SENSOR_DEVICE_ATTR_RO(in4_input, in, 3);
+static SENSOR_DEVICE_ATTR_RO(in5_input, in, 4);
+static SENSOR_DEVICE_ATTR_RO(in6_input, in, 5);
+static SENSOR_DEVICE_ATTR_RO(in7_input, in, 6);
+static SENSOR_DEVICE_ATTR_RO(in8_input, in, 7);
+static SENSOR_DEVICE_ATTR_RO(in9_input, in, 8);
+static SENSOR_DEVICE_ATTR_RO(in10_input, in, 9);
+static SENSOR_DEVICE_ATTR_RO(in11_input, in, 10);
+static SENSOR_DEVICE_ATTR_RO(in12_input, in, 11);
+static SENSOR_DEVICE_ATTR_RO(in13_input, in, 12);
+static SENSOR_DEVICE_ATTR_RO(in14_input, in, 13);
+static SENSOR_DEVICE_ATTR_RO(in15_input, in, 14);
+static SENSOR_DEVICE_ATTR_RO(in16_input, in, 15);

-static ssize_t show_in_min(struct device *dev,
+static ssize_t in_min_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1154,7 +1154,7 @@ static ssize_t show_in_min(struct device
 	return sprintf(buf, "%ld\n", rc);
 }

-static ssize_t store_in_min(struct device *dev, struct device_attribute *attr,
+static ssize_t in_min_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1185,40 +1185,24 @@ static ssize_t store_in_min(struct devic
 	return count;
 }

-static SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 0);
-static SENSOR_DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 1);
-static SENSOR_DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 2);
-static SENSOR_DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 3);
-static SENSOR_DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 4);
-static SENSOR_DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 5);
-static SENSOR_DEVICE_ATTR(in7_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 6);
-static SENSOR_DEVICE_ATTR(in8_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 7);
-static SENSOR_DEVICE_ATTR(in9_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 8);
-static SENSOR_DEVICE_ATTR(in10_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 9);
-static SENSOR_DEVICE_ATTR(in11_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 10);
-static SENSOR_DEVICE_ATTR(in12_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 11);
-static SENSOR_DEVICE_ATTR(in13_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 12);
-static SENSOR_DEVICE_ATTR(in14_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 13);
-static SENSOR_DEVICE_ATTR(in15_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 14);
-static SENSOR_DEVICE_ATTR(in16_min, S_IWUSR | S_IRUGO,
-			  show_in_min, store_in_min, 15);
+static SENSOR_DEVICE_ATTR_RW(in1_min, in_min, 0);
+static SENSOR_DEVICE_ATTR_RW(in2_min, in_min, 1);
+static SENSOR_DEVICE_ATTR_RW(in3_min, in_min, 2);
+static SENSOR_DEVICE_ATTR_RW(in4_min, in_min, 3);
+static SENSOR_DEVICE_ATTR_RW(in5_min, in_min, 4);
+static SENSOR_DEVICE_ATTR_RW(in6_min, in_min, 5);
+static SENSOR_DEVICE_ATTR_RW(in7_min, in_min, 6);
+static SENSOR_DEVICE_ATTR_RW(in8_min, in_min, 7);
+static SENSOR_DEVICE_ATTR_RW(in9_min, in_min, 8);
+static SENSOR_DEVICE_ATTR_RW(in10_min, in_min, 9);
+static SENSOR_DEVICE_ATTR_RW(in11_min, in_min, 10);
+static SENSOR_DEVICE_ATTR_RW(in12_min, in_min, 11);
+static SENSOR_DEVICE_ATTR_RW(in13_min, in_min, 12);
+static SENSOR_DEVICE_ATTR_RW(in14_min, in_min, 13);
+static SENSOR_DEVICE_ATTR_RW(in15_min, in_min, 14);
+static SENSOR_DEVICE_ATTR_RW(in16_min, in_min, 15);

-static ssize_t show_in_max(struct device *dev,
+static ssize_t in_max_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1235,7 +1219,7 @@ static ssize_t show_in_max(struct device
 	return sprintf(buf, "%ld\n", rc);
 }

-static ssize_t store_in_max(struct device *dev, struct device_attribute *attr,
+static ssize_t in_max_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1266,40 +1250,24 @@ static ssize_t store_in_max(struct devic
 	return count;
 }

-static SENSOR_DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 0);
-static SENSOR_DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 1);
-static SENSOR_DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 2);
-static SENSOR_DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 3);
-static SENSOR_DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 4);
-static SENSOR_DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 5);
-static SENSOR_DEVICE_ATTR(in7_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 6);
-static SENSOR_DEVICE_ATTR(in8_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 7);
-static SENSOR_DEVICE_ATTR(in9_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 8);
-static SENSOR_DEVICE_ATTR(in10_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 9);
-static SENSOR_DEVICE_ATTR(in11_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 10);
-static SENSOR_DEVICE_ATTR(in12_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 11);
-static SENSOR_DEVICE_ATTR(in13_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 12);
-static SENSOR_DEVICE_ATTR(in14_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 13);
-static SENSOR_DEVICE_ATTR(in15_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 14);
-static SENSOR_DEVICE_ATTR(in16_max, S_IWUSR | S_IRUGO,
-			  show_in_max, store_in_max, 15);
+static SENSOR_DEVICE_ATTR_RW(in1_max, in_max, 0);
+static SENSOR_DEVICE_ATTR_RW(in2_max, in_max, 1);
+static SENSOR_DEVICE_ATTR_RW(in3_max, in_max, 2);
+static SENSOR_DEVICE_ATTR_RW(in4_max, in_max, 3);
+static SENSOR_DEVICE_ATTR_RW(in5_max, in_max, 4);
+static SENSOR_DEVICE_ATTR_RW(in6_max, in_max, 5);
+static SENSOR_DEVICE_ATTR_RW(in7_max, in_max, 6);
+static SENSOR_DEVICE_ATTR_RW(in8_max, in_max, 7);
+static SENSOR_DEVICE_ATTR_RW(in9_max, in_max, 8);
+static SENSOR_DEVICE_ATTR_RW(in10_max, in_max, 9);
+static SENSOR_DEVICE_ATTR_RW(in11_max, in_max, 10);
+static SENSOR_DEVICE_ATTR_RW(in12_max, in_max, 11);
+static SENSOR_DEVICE_ATTR_RW(in13_max, in_max, 12);
+static SENSOR_DEVICE_ATTR_RW(in14_max, in_max, 13);
+static SENSOR_DEVICE_ATTR_RW(in15_max, in_max, 14);
+static SENSOR_DEVICE_ATTR_RW(in16_max, in_max, 15);

-static ssize_t show_temp(struct device *dev,
+static ssize_t temp_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1307,11 +1275,11 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->block2[nr]));
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);

-static ssize_t show_temp_min(struct device *dev,
+static ssize_t temp_min_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1319,7 +1287,7 @@ static ssize_t show_temp_min(struct devi
 	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->temp_lim[nr].min));
 }

-static ssize_t store_temp_min(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_min_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1339,14 +1307,11 @@ static ssize_t store_temp_min(struct dev
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
-			  show_temp_min, store_temp_min, 0);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO,
-			  show_temp_min, store_temp_min, 1);
-static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO,
-			  show_temp_min, store_temp_min, 2);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp_min, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_min, temp_min, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_min, temp_min, 2);

-static ssize_t show_temp_max(struct device *dev,
+static ssize_t temp_max_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1354,7 +1319,7 @@ static ssize_t show_temp_max(struct devi
 	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->temp_lim[nr].max));
 }

-static ssize_t store_temp_max(struct device *dev, struct device_attribute *attr,
+static ssize_t temp_max_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1374,14 +1339,11 @@ static ssize_t store_temp_max(struct dev
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
-			  show_temp_max, store_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO,
-			  show_temp_max, store_temp_max, 1);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO,
-			  show_temp_max, store_temp_max, 2);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, temp_max, 2);

-static ssize_t show_temp_auto_base(struct device *dev,
+static ssize_t temp_auto_base_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1389,7 +1351,7 @@ static ssize_t show_temp_auto_base(struc
 	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->block10.base[nr]));
 }

-static ssize_t store_temp_auto_base(struct device *dev,
+static ssize_t temp_auto_base_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -1410,14 +1372,11 @@ static ssize_t store_temp_auto_base(stru
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_auto_base, S_IWUSR | S_IRUGO,
-			  show_temp_auto_base, store_temp_auto_base, 0);
-static SENSOR_DEVICE_ATTR(temp2_auto_base, S_IWUSR | S_IRUGO,
-			  show_temp_auto_base, store_temp_auto_base, 1);
-static SENSOR_DEVICE_ATTR(temp3_auto_base, S_IWUSR | S_IRUGO,
-			  show_temp_auto_base, store_temp_auto_base, 2);
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_base, temp_auto_base, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_auto_base, temp_auto_base, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_auto_base, temp_auto_base, 2);

-static ssize_t show_temp_auto_boost(struct device *dev,
+static ssize_t temp_auto_boost_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1425,7 +1384,7 @@ static ssize_t show_temp_auto_boost(stru
 	return sprintf(buf, "%d\n", LM93_TEMP_FROM_REG(data->boost[nr]));
 }

-static ssize_t store_temp_auto_boost(struct device *dev,
+static ssize_t temp_auto_boost_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
@@ -1446,14 +1405,11 @@ static ssize_t store_temp_auto_boost(str
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_auto_boost, S_IWUSR | S_IRUGO,
-			  show_temp_auto_boost, store_temp_auto_boost, 0);
-static SENSOR_DEVICE_ATTR(temp2_auto_boost, S_IWUSR | S_IRUGO,
-			  show_temp_auto_boost, store_temp_auto_boost, 1);
-static SENSOR_DEVICE_ATTR(temp3_auto_boost, S_IWUSR | S_IRUGO,
-			  show_temp_auto_boost, store_temp_auto_boost, 2);
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_boost, temp_auto_boost, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_auto_boost, temp_auto_boost, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_auto_boost, temp_auto_boost, 2);

-static ssize_t show_temp_auto_boost_hyst(struct device *dev,
+static ssize_t temp_auto_boost_hyst_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
@@ -1464,7 +1420,7 @@ static ssize_t show_temp_auto_boost_hyst
 		       LM93_AUTO_BOOST_HYST_FROM_REGS(data, nr, mode));
 }

-static ssize_t store_temp_auto_boost_hyst(struct device *dev,
+static ssize_t temp_auto_boost_hyst_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t count)
 {
@@ -1490,17 +1446,11 @@ static ssize_t store_temp_auto_boost_hys
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_auto_boost_hyst, S_IWUSR | S_IRUGO,
-			  show_temp_auto_boost_hyst,
-			  store_temp_auto_boost_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp2_auto_boost_hyst, S_IWUSR | S_IRUGO,
-			  show_temp_auto_boost_hyst,
-			  store_temp_auto_boost_hyst, 1);
-static SENSOR_DEVICE_ATTR(temp3_auto_boost_hyst, S_IWUSR | S_IRUGO,
-			  show_temp_auto_boost_hyst,
-			  store_temp_auto_boost_hyst, 2);
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_boost_hyst, temp_auto_boost_hyst, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_auto_boost_hyst, temp_auto_boost_hyst, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_auto_boost_hyst, temp_auto_boost_hyst, 2);

-static ssize_t show_temp_auto_offset(struct device *dev,
+static ssize_t temp_auto_offset_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute_2 *s_attr = to_sensor_dev_attr_2(attr);
@@ -1513,7 +1463,7 @@ static ssize_t show_temp_auto_offset(str
 					      nr, mode));
 }

-static ssize_t store_temp_auto_offset(struct device *dev,
+static ssize_t temp_auto_offset_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -1542,80 +1492,44 @@ static ssize_t store_temp_auto_offset(st
 	return count;
 }

-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset1, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 0, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset2, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 1, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset3, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 2, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset4, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 3, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset5, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 4, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset6, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 5, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset7, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 6, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset8, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 7, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset9, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 8, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset10, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 9, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset11, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 10, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_offset12, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 11, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset1, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 0, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset2, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 1, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset3, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 2, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset4, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 3, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset5, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 4, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset6, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 5, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset7, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 6, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset8, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 7, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset9, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 8, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset10, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 9, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset11, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 10, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_offset12, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 11, 1);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset1, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 0, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset2, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 1, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset3, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 2, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset4, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 3, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset5, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 4, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset6, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 5, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset7, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 6, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset8, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 7, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset9, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 8, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset10, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 9, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset11, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 10, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_auto_offset12, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset, store_temp_auto_offset, 11, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset1, temp_auto_offset, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset2, temp_auto_offset, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset3, temp_auto_offset, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset4, temp_auto_offset, 3, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset5, temp_auto_offset, 4, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset6, temp_auto_offset, 5, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset7, temp_auto_offset, 6, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset8, temp_auto_offset, 7, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset9, temp_auto_offset, 8, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset10, temp_auto_offset, 9, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset11, temp_auto_offset, 10, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_offset12, temp_auto_offset, 11, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset1, temp_auto_offset, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset2, temp_auto_offset, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset3, temp_auto_offset, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset4, temp_auto_offset, 3, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset5, temp_auto_offset, 4, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset6, temp_auto_offset, 5, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset7, temp_auto_offset, 6, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset8, temp_auto_offset, 7, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset9, temp_auto_offset, 8, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset10, temp_auto_offset, 9, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset11, temp_auto_offset, 10, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_offset12, temp_auto_offset, 11, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset1, temp_auto_offset, 0, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset2, temp_auto_offset, 1, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset3, temp_auto_offset, 2, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset4, temp_auto_offset, 3, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset5, temp_auto_offset, 4, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset6, temp_auto_offset, 5, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset7, temp_auto_offset, 6, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset8, temp_auto_offset, 7, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset9, temp_auto_offset, 8, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset10, temp_auto_offset, 9, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset11, temp_auto_offset, 10, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_auto_offset12, temp_auto_offset, 11, 2);

-static ssize_t show_temp_auto_pwm_min(struct device *dev,
+static ssize_t temp_auto_pwm_min_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1627,7 +1541,7 @@ static ssize_t show_temp_auto_pwm_min(st
 				LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ));
 }

-static ssize_t store_temp_auto_pwm_min(struct device *dev,
+static ssize_t temp_auto_pwm_min_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -1655,17 +1569,11 @@ static ssize_t store_temp_auto_pwm_min(s
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_auto_pwm_min, S_IWUSR | S_IRUGO,
-			  show_temp_auto_pwm_min,
-			  store_temp_auto_pwm_min, 0);
-static SENSOR_DEVICE_ATTR(temp2_auto_pwm_min, S_IWUSR | S_IRUGO,
-			  show_temp_auto_pwm_min,
-			  store_temp_auto_pwm_min, 1);
-static SENSOR_DEVICE_ATTR(temp3_auto_pwm_min, S_IWUSR | S_IRUGO,
-			  show_temp_auto_pwm_min,
-			  store_temp_auto_pwm_min, 2);
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_pwm_min, temp_auto_pwm_min, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_auto_pwm_min, temp_auto_pwm_min, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_auto_pwm_min, temp_auto_pwm_min, 2);

-static ssize_t show_temp_auto_offset_hyst(struct device *dev,
+static ssize_t temp_auto_offset_hyst_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1675,7 +1583,7 @@ static ssize_t show_temp_auto_offset_hys
 					data->auto_pwm_min_hyst[nr / 2], mode));
 }

-static ssize_t store_temp_auto_offset_hyst(struct device *dev,
+static ssize_t temp_auto_offset_hyst_store(struct device *dev,
 						struct device_attribute *attr,
 						const char *buf, size_t count)
 {
@@ -1703,17 +1611,11 @@ static ssize_t store_temp_auto_offset_hy
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_auto_offset_hyst, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset_hyst,
-			  store_temp_auto_offset_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp2_auto_offset_hyst, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset_hyst,
-			  store_temp_auto_offset_hyst, 1);
-static SENSOR_DEVICE_ATTR(temp3_auto_offset_hyst, S_IWUSR | S_IRUGO,
-			  show_temp_auto_offset_hyst,
-			  store_temp_auto_offset_hyst, 2);
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_offset_hyst, temp_auto_offset_hyst, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_auto_offset_hyst, temp_auto_offset_hyst, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_auto_offset_hyst, temp_auto_offset_hyst, 2);

-static ssize_t show_fan_input(struct device *dev,
+static ssize_t fan_input_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
@@ -1723,12 +1625,12 @@ static ssize_t show_fan_input(struct dev
 	return sprintf(buf, "%d\n", LM93_FAN_FROM_REG(data->block5[nr]));
 }

-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan_input, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan_input, NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan_input, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan_input, 3);

-static ssize_t show_fan_min(struct device *dev,
+static ssize_t fan_min_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1737,7 +1639,7 @@ static ssize_t show_fan_min(struct devic
 	return sprintf(buf, "%d\n", LM93_FAN_FROM_REG(data->block8[nr]));
 }

-static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
+static ssize_t fan_min_store(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1757,14 +1659,10 @@ static ssize_t store_fan_min(struct devi
 	return count;
 }

-static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, store_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, store_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, store_fan_min, 2);
-static SENSOR_DEVICE_ATTR(fan4_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, store_fan_min, 3);
+static SENSOR_DEVICE_ATTR_RW(fan1_min, fan_min, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_min, fan_min, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_min, fan_min, 2);
+static SENSOR_DEVICE_ATTR_RW(fan4_min, fan_min, 3);

 /*
  * some tedious bit-twiddling here to deal with the register format:
@@ -1780,7 +1678,7 @@ static SENSOR_DEVICE_ATTR(fan4_min, S_IW
  *		       T4    T3    T2    T1
  */

-static ssize_t show_fan_smart_tach(struct device *dev,
+static ssize_t fan_smart_tach_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1819,7 +1717,7 @@ static void lm93_write_fan_smart_tach(st
 	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
 }

-static ssize_t store_fan_smart_tach(struct device *dev,
+static ssize_t fan_smart_tach_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -1849,16 +1747,12 @@ static ssize_t store_fan_smart_tach(stru
 	return count;
 }

-static SENSOR_DEVICE_ATTR(fan1_smart_tach, S_IWUSR | S_IRUGO,
-			  show_fan_smart_tach, store_fan_smart_tach, 0);
-static SENSOR_DEVICE_ATTR(fan2_smart_tach, S_IWUSR | S_IRUGO,
-			  show_fan_smart_tach, store_fan_smart_tach, 1);
-static SENSOR_DEVICE_ATTR(fan3_smart_tach, S_IWUSR | S_IRUGO,
-			  show_fan_smart_tach, store_fan_smart_tach, 2);
-static SENSOR_DEVICE_ATTR(fan4_smart_tach, S_IWUSR | S_IRUGO,
-			  show_fan_smart_tach, store_fan_smart_tach, 3);
+static SENSOR_DEVICE_ATTR_RW(fan1_smart_tach, fan_smart_tach, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_smart_tach, fan_smart_tach, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_smart_tach, fan_smart_tach, 2);
+static SENSOR_DEVICE_ATTR_RW(fan4_smart_tach, fan_smart_tach, 3);

-static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1876,7 +1770,7 @@ static ssize_t show_pwm(struct device *d
 	return sprintf(buf, "%ld\n", rc);
 }

-static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
+static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1904,10 +1798,10 @@ static ssize_t store_pwm(struct device *
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);

-static ssize_t show_pwm_enable(struct device *dev,
+static ssize_t pwm_enable_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -1923,7 +1817,7 @@ static ssize_t show_pwm_enable(struct de
 	return sprintf(buf, "%ld\n", rc);
 }

-static ssize_t store_pwm_enable(struct device *dev,
+static ssize_t pwm_enable_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
@@ -1961,12 +1855,10 @@ static ssize_t store_pwm_enable(struct d
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
-				show_pwm_enable, store_pwm_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO,
-				show_pwm_enable, store_pwm_enable, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_enable, 1);

-static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
+static ssize_t pwm_freq_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2001,7 +1893,7 @@ static void lm93_disable_fan_smart_tach(
 	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
 }

-static ssize_t store_pwm_freq(struct device *dev,
+static ssize_t pwm_freq_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
@@ -2028,12 +1920,10 @@ static ssize_t store_pwm_freq(struct dev
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1_freq, S_IWUSR | S_IRUGO,
-			  show_pwm_freq, store_pwm_freq, 0);
-static SENSOR_DEVICE_ATTR(pwm2_freq, S_IWUSR | S_IRUGO,
-			  show_pwm_freq, store_pwm_freq, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1_freq, pwm_freq, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_freq, pwm_freq, 1);

-static ssize_t show_pwm_auto_channels(struct device *dev,
+static ssize_t pwm_auto_channels_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2041,7 +1931,7 @@ static ssize_t show_pwm_auto_channels(st
 	return sprintf(buf, "%d\n", data->block9[nr][LM93_PWM_CTL1]);
 }

-static ssize_t store_pwm_auto_channels(struct device *dev,
+static ssize_t pwm_auto_channels_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -2063,12 +1953,10 @@ static ssize_t store_pwm_auto_channels(s
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1_auto_channels, S_IWUSR | S_IRUGO,
-			  show_pwm_auto_channels, store_pwm_auto_channels, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_channels, S_IWUSR | S_IRUGO,
-			  show_pwm_auto_channels, store_pwm_auto_channels, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_channels, pwm_auto_channels, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_channels, pwm_auto_channels, 1);

-static ssize_t show_pwm_auto_spinup_min(struct device *dev,
+static ssize_t pwm_auto_spinup_min_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2082,7 +1970,7 @@ static ssize_t show_pwm_auto_spinup_min(
 			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ));
 }

-static ssize_t store_pwm_auto_spinup_min(struct device *dev,
+static ssize_t pwm_auto_spinup_min_store(struct device *dev,
 						struct device_attribute *attr,
 						const char *buf, size_t count)
 {
@@ -2109,14 +1997,10 @@ static ssize_t store_pwm_auto_spinup_min
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1_auto_spinup_min, S_IWUSR | S_IRUGO,
-			  show_pwm_auto_spinup_min,
-			  store_pwm_auto_spinup_min, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_spinup_min, S_IWUSR | S_IRUGO,
-			  show_pwm_auto_spinup_min,
-			  store_pwm_auto_spinup_min, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_spinup_min, pwm_auto_spinup_min, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_spinup_min, pwm_auto_spinup_min, 1);

-static ssize_t show_pwm_auto_spinup_time(struct device *dev,
+static ssize_t pwm_auto_spinup_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2125,7 +2009,7 @@ static ssize_t show_pwm_auto_spinup_time
 				data->block9[nr][LM93_PWM_CTL3]));
 }

-static ssize_t store_pwm_auto_spinup_time(struct device *dev,
+static ssize_t pwm_auto_spinup_time_store(struct device *dev,
 						struct device_attribute *attr,
 						const char *buf, size_t count)
 {
@@ -2149,12 +2033,8 @@ static ssize_t store_pwm_auto_spinup_tim
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1_auto_spinup_time, S_IWUSR | S_IRUGO,
-			  show_pwm_auto_spinup_time,
-			  store_pwm_auto_spinup_time, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_spinup_time, S_IWUSR | S_IRUGO,
-			  show_pwm_auto_spinup_time,
-			  store_pwm_auto_spinup_time, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_spinup_time, pwm_auto_spinup_time, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_spinup_time, pwm_auto_spinup_time, 1);

 static ssize_t show_pwm_auto_prochot_ramp(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -2224,7 +2104,7 @@ static DEVICE_ATTR(pwm_auto_vrdhot_ramp,
 			show_pwm_auto_vrdhot_ramp,
 			store_pwm_auto_vrdhot_ramp);

-static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
+static ssize_t vid_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2232,10 +2112,10 @@ static ssize_t show_vid(struct device *d
 	return sprintf(buf, "%d\n", LM93_VID_FROM_REG(data->vid[nr]));
 }

-static SENSOR_DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL, 0);
-static SENSOR_DEVICE_ATTR(cpu1_vid, S_IRUGO, show_vid, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(cpu0_vid, vid, 0);
+static SENSOR_DEVICE_ATTR_RO(cpu1_vid, vid, 1);

-static ssize_t show_prochot(struct device *dev, struct device_attribute *attr,
+static ssize_t prochot_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2243,10 +2123,10 @@ static ssize_t show_prochot(struct devic
 	return sprintf(buf, "%d\n", data->block4[nr].cur);
 }

-static SENSOR_DEVICE_ATTR(prochot1, S_IRUGO, show_prochot, NULL, 0);
-static SENSOR_DEVICE_ATTR(prochot2, S_IRUGO, show_prochot, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(prochot1, prochot, 0);
+static SENSOR_DEVICE_ATTR_RO(prochot2, prochot, 1);

-static ssize_t show_prochot_avg(struct device *dev,
+static ssize_t prochot_avg_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2254,10 +2134,10 @@ static ssize_t show_prochot_avg(struct d
 	return sprintf(buf, "%d\n", data->block4[nr].avg);
 }

-static SENSOR_DEVICE_ATTR(prochot1_avg, S_IRUGO, show_prochot_avg, NULL, 0);
-static SENSOR_DEVICE_ATTR(prochot2_avg, S_IRUGO, show_prochot_avg, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(prochot1_avg, prochot_avg, 0);
+static SENSOR_DEVICE_ATTR_RO(prochot2_avg, prochot_avg, 1);

-static ssize_t show_prochot_max(struct device *dev,
+static ssize_t prochot_max_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2265,7 +2145,7 @@ static ssize_t show_prochot_max(struct d
 	return sprintf(buf, "%d\n", data->prochot_max[nr]);
 }

-static ssize_t store_prochot_max(struct device *dev,
+static ssize_t prochot_max_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -2287,14 +2167,12 @@ static ssize_t store_prochot_max(struct
 	return count;
 }

-static SENSOR_DEVICE_ATTR(prochot1_max, S_IWUSR | S_IRUGO,
-			  show_prochot_max, store_prochot_max, 0);
-static SENSOR_DEVICE_ATTR(prochot2_max, S_IWUSR | S_IRUGO,
-			  show_prochot_max, store_prochot_max, 1);
+static SENSOR_DEVICE_ATTR_RW(prochot1_max, prochot_max, 0);
+static SENSOR_DEVICE_ATTR_RW(prochot2_max, prochot_max, 1);

 static const u8 prochot_override_mask[] = { 0x80, 0x40 };

-static ssize_t show_prochot_override(struct device *dev,
+static ssize_t prochot_override_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2303,7 +2181,7 @@ static ssize_t show_prochot_override(str
 		(data->prochot_override & prochot_override_mask[nr]) ? 1 : 0);
 }

-static ssize_t store_prochot_override(struct device *dev,
+static ssize_t prochot_override_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -2328,12 +2206,10 @@ static ssize_t store_prochot_override(st
 	return count;
 }

-static SENSOR_DEVICE_ATTR(prochot1_override, S_IWUSR | S_IRUGO,
-			  show_prochot_override, store_prochot_override, 0);
-static SENSOR_DEVICE_ATTR(prochot2_override, S_IWUSR | S_IRUGO,
-			  show_prochot_override, store_prochot_override, 1);
+static SENSOR_DEVICE_ATTR_RW(prochot1_override, prochot_override, 0);
+static SENSOR_DEVICE_ATTR_RW(prochot2_override, prochot_override, 1);

-static ssize_t show_prochot_interval(struct device *dev,
+static ssize_t prochot_interval_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2346,7 +2222,7 @@ static ssize_t show_prochot_interval(str
 	return sprintf(buf, "%d\n", LM93_INTERVAL_FROM_REG(tmp));
 }

-static ssize_t store_prochot_interval(struct device *dev,
+static ssize_t prochot_interval_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -2373,10 +2249,8 @@ static ssize_t store_prochot_interval(st
 	return count;
 }

-static SENSOR_DEVICE_ATTR(prochot1_interval, S_IWUSR | S_IRUGO,
-			  show_prochot_interval, store_prochot_interval, 0);
-static SENSOR_DEVICE_ATTR(prochot2_interval, S_IWUSR | S_IRUGO,
-			  show_prochot_interval, store_prochot_interval, 1);
+static SENSOR_DEVICE_ATTR_RW(prochot1_interval, prochot_interval, 0);
+static SENSOR_DEVICE_ATTR_RW(prochot2_interval, prochot_interval, 1);

 static ssize_t show_prochot_override_duty_cycle(struct device *dev,
 						struct device_attribute *attr,
@@ -2445,7 +2319,7 @@ static ssize_t store_prochot_short(struc
 static DEVICE_ATTR(prochot_short, S_IRUGO | S_IWUSR,
 		   show_prochot_short, store_prochot_short);

-static ssize_t show_vrdhot(struct device *dev, struct device_attribute *attr,
+static ssize_t vrdhot_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
 	int nr = (to_sensor_dev_attr(attr))->index;
@@ -2454,8 +2328,8 @@ static ssize_t show_vrdhot(struct device
 		       data->block1.host_status_1 & (1 << (nr + 4)) ? 1 : 0);
 }

-static SENSOR_DEVICE_ATTR(vrdhot1, S_IRUGO, show_vrdhot, NULL, 0);
-static SENSOR_DEVICE_ATTR(vrdhot2, S_IRUGO, show_vrdhot, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(vrdhot1, vrdhot, 0);
+static SENSOR_DEVICE_ATTR_RO(vrdhot2, vrdhot, 1);

 static ssize_t show_gpio(struct device *dev, struct device_attribute *attr,
 				char *buf)
diff -u -p a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -53,7 +53,7 @@ static int ad7314_spi_read(struct ad7314
 	return be16_to_cpu(chip->rx);
 }

-static ssize_t ad7314_show_temperature(struct device *dev,
+static ssize_t ad7314_temperature_show(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
@@ -87,8 +87,7 @@ static ssize_t ad7314_show_temperature(s
 	}
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
-			  ad7314_show_temperature, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, ad7314_temperature, 0);

 static struct attribute *ad7314_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/thmc50.c b/drivers/hwmon/thmc50.c
--- a/drivers/hwmon/thmc50.c
+++ b/drivers/hwmon/thmc50.c
@@ -128,16 +128,16 @@ static struct thmc50_data *thmc50_update
 	return data;
 }

-static ssize_t show_analog_out(struct device *dev,
+static ssize_t analog_out_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct thmc50_data *data = thmc50_update_device(dev);
 	return sprintf(buf, "%d\n", data->analog_out);
 }

-static ssize_t set_analog_out(struct device *dev,
-			      struct device_attribute *attr,
-			      const char *buf, size_t count)
+static ssize_t analog_out_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	struct thmc50_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -166,7 +166,7 @@ static ssize_t set_analog_out(struct dev
 }

 /* There is only one PWM mode = DC */
-static ssize_t show_pwm_mode(struct device *dev, struct device_attribute *attr,
+static ssize_t pwm_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
 	return sprintf(buf, "0\n");
@@ -248,7 +248,7 @@ static ssize_t show_temp_critical(struct
 	return sprintf(buf, "%d\n", data->temp_critical[nr] * 1000);
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int index = to_sensor_dev_attr(attr)->index;
@@ -271,15 +271,14 @@ temp_reg(1);
 temp_reg(2);
 temp_reg(3);

-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 2);
-
-static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_analog_out,
-			  set_analog_out, 0);
-static SENSOR_DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 2);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1, analog_out, 0);
+static SENSOR_DEVICE_ATTR_RO(pwm1_mode, pwm_mode, 0);

 static struct attribute *thmc50_attributes[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
diff -u -p a/drivers/hwmon/sht21.c b/drivers/hwmon/sht21.c
--- a/drivers/hwmon/sht21.c
+++ b/drivers/hwmon/sht21.c
@@ -130,7 +130,7 @@ out:
  * Will be called on read access to temp1_input sysfs attribute.
  * Returns number of bytes written into buffer, negative errno on error.
  */
-static ssize_t sht21_show_temperature(struct device *dev,
+static ssize_t sht21_temperature_show(struct device *dev,
 	struct device_attribute *attr,
 	char *buf)
 {
@@ -152,7 +152,7 @@ static ssize_t sht21_show_temperature(st
  * Will be called on read access to humidity1_input sysfs attribute.
  * Returns number of bytes written into buffer, negative errno on error.
  */
-static ssize_t sht21_show_humidity(struct device *dev,
+static ssize_t sht21_humidity_show(struct device *dev,
 	struct device_attribute *attr,
 	char *buf)
 {
@@ -166,10 +166,8 @@ static ssize_t sht21_show_humidity(struc
 }

 /* sysfs attributes */
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, sht21_show_temperature,
-	NULL, 0);
-static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO, sht21_show_humidity,
-	NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, sht21_temperature, 0);
+static SENSOR_DEVICE_ATTR_RO(humidity1_input, sht21_humidity, 0);

 static struct attribute *sht21_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -500,21 +500,21 @@ static ssize_t show_alarms(struct device
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *da,
 			  char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	int nr = to_sensor_dev_attr(da)->index;
 	return sprintf(buf, "%u\n", (data->alarms >> nr) & 1);
 }
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 15);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 15);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 15);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 15);

 static ssize_t show_name(struct device *dev, struct device_attribute *attr,
 			 char *buf)
diff -u -p a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -164,7 +164,7 @@ static int temp_from_reg(u8 reg)
 	return (s8)reg * 1000;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute
+static ssize_t temp_show(struct device *dev, struct device_attribute
 			 *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -172,10 +172,10 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", temp_from_reg(data->temp[attr->index]));
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 3);

 /*
  * FAN: 1 RPM/bit
@@ -188,17 +188,17 @@ static int fan_from_reg(u16 reg)
 	return 90000 * 60 / reg;
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute
+static ssize_t fan_show(struct device *dev, struct device_attribute
 			*devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct smsc47b397_data *data = smsc47b397_update_device(dev);
 	return sprintf(buf, "%d\n", fan_from_reg(data->fan[attr->index]));
 }
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan, 3);

 static struct attribute *smsc47b397_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/max31722.c b/drivers/hwmon/max31722.c
--- a/drivers/hwmon/max31722.c
+++ b/drivers/hwmon/max31722.c
@@ -50,7 +50,7 @@ static int max31722_set_mode(struct max3
 	return 0;
 }

-static ssize_t max31722_show_temp(struct device *dev,
+static ssize_t max31722_temp_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
@@ -64,8 +64,7 @@ static ssize_t max31722_show_temp(struct
 	return sprintf(buf, "%d\n", (s16)le16_to_cpu(ret) * 125 / 32);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
-			  max31722_show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, max31722_temp, 0);

 static struct attribute *max31722_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -226,7 +226,7 @@ static int ltc2945_val_to_reg(struct dev
 	return val;
 }

-static ssize_t ltc2945_show_value(struct device *dev,
+static ssize_t ltc2945_value_show(struct device *dev,
 				  struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -238,9 +238,9 @@ static ssize_t ltc2945_show_value(struct
 	return snprintf(buf, PAGE_SIZE, "%lld\n", value);
 }

-static ssize_t ltc2945_set_value(struct device *dev,
-				     struct device_attribute *da,
-				     const char *buf, size_t count)
+static ssize_t ltc2945_value_store(struct device *dev,
+				   struct device_attribute *da,
+				   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct regmap *regmap = dev_get_drvdata(dev);
@@ -273,9 +273,9 @@ static ssize_t ltc2945_set_value(struct
 	return ret < 0 ? ret : count;
 }

-static ssize_t ltc2945_reset_history(struct device *dev,
-				     struct device_attribute *da,
-				     const char *buf, size_t count)
+static ssize_t ltc2945_rehistory_store(struct device *dev,
+				       struct device_attribute *da,
+				       const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct regmap *regmap = dev_get_drvdata(dev);
@@ -326,7 +326,7 @@ static ssize_t ltc2945_reset_history(str
 	return ret ? : count;
 }

-static ssize_t ltc2945_show_bool(struct device *dev,
+static ssize_t ltc2945_bool_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -347,86 +347,65 @@ static ssize_t ltc2945_show_bool(struct

 /* Input voltages */

-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_VIN_H);
-static SENSOR_DEVICE_ATTR(in1_min, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MIN_VIN_THRES_H);
-static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MAX_VIN_THRES_H);
-static SENSOR_DEVICE_ATTR(in1_lowest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MIN_VIN_H);
-static SENSOR_DEVICE_ATTR(in1_highest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MAX_VIN_H);
-static SENSOR_DEVICE_ATTR(in1_reset_history, S_IWUSR, NULL,
-			  ltc2945_reset_history, LTC2945_MIN_VIN_H);
-
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_ADIN_H);
-static SENSOR_DEVICE_ATTR(in2_min, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MIN_ADIN_THRES_H);
-static SENSOR_DEVICE_ATTR(in2_max, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MAX_ADIN_THRES_H);
-static SENSOR_DEVICE_ATTR(in2_lowest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MIN_ADIN_H);
-static SENSOR_DEVICE_ATTR(in2_highest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MAX_ADIN_H);
-static SENSOR_DEVICE_ATTR(in2_reset_history, S_IWUSR, NULL,
-			  ltc2945_reset_history, LTC2945_MIN_ADIN_H);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ltc2945_value, LTC2945_VIN_H);
+static SENSOR_DEVICE_ATTR_RW(in1_min, ltc2945_value, LTC2945_MIN_VIN_THRES_H);
+static SENSOR_DEVICE_ATTR_RW(in1_max, ltc2945_value, LTC2945_MAX_VIN_THRES_H);
+static SENSOR_DEVICE_ATTR_RO(in1_lowest, ltc2945_value, LTC2945_MIN_VIN_H);
+static SENSOR_DEVICE_ATTR_RO(in1_highest, ltc2945_value, LTC2945_MAX_VIN_H);
+static SENSOR_DEVICE_ATTR_WO(in1_reset_history, ltc2945_rehistory,
+			     LTC2945_MIN_VIN_H);
+
+static SENSOR_DEVICE_ATTR_RO(in2_input, ltc2945_value, LTC2945_ADIN_H);
+static SENSOR_DEVICE_ATTR_RW(in2_min, ltc2945_value, LTC2945_MIN_ADIN_THRES_H);
+static SENSOR_DEVICE_ATTR_RW(in2_max, ltc2945_value, LTC2945_MAX_ADIN_THRES_H);
+static SENSOR_DEVICE_ATTR_RO(in2_lowest, ltc2945_value, LTC2945_MIN_ADIN_H);
+static SENSOR_DEVICE_ATTR_RO(in2_highest, ltc2945_value, LTC2945_MAX_ADIN_H);
+static SENSOR_DEVICE_ATTR_WO(in2_reset_history, ltc2945_rehistory,
+			     LTC2945_MIN_ADIN_H);

 /* Voltage alarms */

-static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_VIN_UV);
-static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_VIN_OV);
-static SENSOR_DEVICE_ATTR(in2_min_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_ADIN_UV);
-static SENSOR_DEVICE_ATTR(in2_max_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_ADIN_OV);
+static SENSOR_DEVICE_ATTR_RO(in1_min_alarm, ltc2945_bool, FAULT_VIN_UV);
+static SENSOR_DEVICE_ATTR_RO(in1_max_alarm, ltc2945_bool, FAULT_VIN_OV);
+static SENSOR_DEVICE_ATTR_RO(in2_min_alarm, ltc2945_bool, FAULT_ADIN_UV);
+static SENSOR_DEVICE_ATTR_RO(in2_max_alarm, ltc2945_bool, FAULT_ADIN_OV);

 /* Currents (via sense resistor) */

-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_SENSE_H);
-static SENSOR_DEVICE_ATTR(curr1_min, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MIN_SENSE_THRES_H);
-static SENSOR_DEVICE_ATTR(curr1_max, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MAX_SENSE_THRES_H);
-static SENSOR_DEVICE_ATTR(curr1_lowest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MIN_SENSE_H);
-static SENSOR_DEVICE_ATTR(curr1_highest, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_MAX_SENSE_H);
-static SENSOR_DEVICE_ATTR(curr1_reset_history, S_IWUSR, NULL,
-			  ltc2945_reset_history, LTC2945_MIN_SENSE_H);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ltc2945_value, LTC2945_SENSE_H);
+static SENSOR_DEVICE_ATTR_RW(curr1_min, ltc2945_value,
+			     LTC2945_MIN_SENSE_THRES_H);
+static SENSOR_DEVICE_ATTR_RW(curr1_max, ltc2945_value,
+			     LTC2945_MAX_SENSE_THRES_H);
+static SENSOR_DEVICE_ATTR_RO(curr1_lowest, ltc2945_value, LTC2945_MIN_SENSE_H);
+static SENSOR_DEVICE_ATTR_RO(curr1_highest, ltc2945_value,
+			     LTC2945_MAX_SENSE_H);
+static SENSOR_DEVICE_ATTR_WO(curr1_reset_history, ltc2945_rehistory,
+			     LTC2945_MIN_SENSE_H);

 /* Current alarms */

-static SENSOR_DEVICE_ATTR(curr1_min_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_SENSE_UV);
-static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_SENSE_OV);
+static SENSOR_DEVICE_ATTR_RO(curr1_min_alarm, ltc2945_bool, FAULT_SENSE_UV);
+static SENSOR_DEVICE_ATTR_RO(curr1_max_alarm, ltc2945_bool, FAULT_SENSE_OV);

 /* Power */

-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ltc2945_show_value, NULL,
-			  LTC2945_POWER_H);
-static SENSOR_DEVICE_ATTR(power1_min, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MIN_POWER_THRES_H);
-static SENSOR_DEVICE_ATTR(power1_max, S_IRUGO | S_IWUSR, ltc2945_show_value,
-			  ltc2945_set_value, LTC2945_MAX_POWER_THRES_H);
-static SENSOR_DEVICE_ATTR(power1_input_lowest, S_IRUGO, ltc2945_show_value,
-			  NULL, LTC2945_MIN_POWER_H);
-static SENSOR_DEVICE_ATTR(power1_input_highest, S_IRUGO, ltc2945_show_value,
-			  NULL, LTC2945_MAX_POWER_H);
-static SENSOR_DEVICE_ATTR(power1_reset_history, S_IWUSR, NULL,
-			  ltc2945_reset_history, LTC2945_MIN_POWER_H);
+static SENSOR_DEVICE_ATTR_RO(power1_input, ltc2945_value, LTC2945_POWER_H);
+static SENSOR_DEVICE_ATTR_RW(power1_min, ltc2945_value,
+			     LTC2945_MIN_POWER_THRES_H);
+static SENSOR_DEVICE_ATTR_RW(power1_max, ltc2945_value,
+			     LTC2945_MAX_POWER_THRES_H);
+static SENSOR_DEVICE_ATTR_RO(power1_input_lowest, ltc2945_value,
+			     LTC2945_MIN_POWER_H);
+static SENSOR_DEVICE_ATTR_RO(power1_input_highest, ltc2945_value,
+			     LTC2945_MAX_POWER_H);
+static SENSOR_DEVICE_ATTR_WO(power1_reset_history, ltc2945_rehistory,
+			     LTC2945_MIN_POWER_H);

 /* Power alarms */

-static SENSOR_DEVICE_ATTR(power1_min_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_POWER_UV);
-static SENSOR_DEVICE_ATTR(power1_max_alarm, S_IRUGO, ltc2945_show_bool, NULL,
-			  FAULT_POWER_OV);
+static SENSOR_DEVICE_ATTR_RO(power1_min_alarm, ltc2945_bool, FAULT_POWER_UV);
+static SENSOR_DEVICE_ATTR_RO(power1_max_alarm, ltc2945_bool, FAULT_POWER_OV);

 static struct attribute *ltc2945_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -269,7 +269,7 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", data->temp / 128 * 500); /* 9-bit value */
 }

-static ssize_t show_max(struct device *dev, struct device_attribute *devattr,
+static ssize_t max_show(struct device *dev, struct device_attribute *devattr,
 		char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -277,8 +277,8 @@ static ssize_t show_max(struct device *d
 	return sprintf(buf, "%d\n", data->temp_max[attr->index] * 1000);
 }

-static ssize_t set_max(struct device *dev, struct device_attribute *devattr,
-		const char *buf, size_t count)
+static ssize_t max_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adm9240_data *data = dev_get_drvdata(dev);
@@ -299,10 +299,8 @@ static ssize_t set_max(struct device *de
 }

 static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
-		show_max, set_max, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
-		show_max, set_max, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, max, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, max, 1);

 /* voltage */
 static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
@@ -509,22 +507,22 @@ static ssize_t show_alarms(struct device
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

-static ssize_t show_alarm(struct device *dev,
+static ssize_t alarm_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 7);

 /* vid */
 static ssize_t show_vid(struct device *dev,
@@ -583,8 +581,8 @@ static ssize_t chassis_clear(struct devi

 	return count;
 }
-static SENSOR_DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR, show_alarm,
-		chassis_clear, 12);
+static SENSOR_DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR, alarm_show,
+			  chassis_clear, 12);

 static struct attribute *adm9240_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -784,7 +784,7 @@ out:
 	return data;
 }

-static ssize_t show_temp_min(struct device *dev,
+static ssize_t temp_min_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -797,10 +797,9 @@ static ssize_t show_temp_min(struct devi
 	return sprintf(buf, "%d\n", 1000 * (data->temp_min[attr->index] - 64));
 }

-static ssize_t set_temp_min(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t temp_min_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -822,7 +821,7 @@ static ssize_t set_temp_min(struct devic
 	return count;
 }

-static ssize_t show_temp_max(struct device *dev,
+static ssize_t temp_max_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -835,10 +834,9 @@ static ssize_t show_temp_max(struct devi
 	return sprintf(buf, "%d\n", 1000 * (data->temp_max[attr->index] - 64));
 }

-static ssize_t set_temp_max(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t temp_max_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -860,7 +858,7 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -874,7 +872,7 @@ static ssize_t show_temp(struct device *
 				     250 * frac);
 }

-static ssize_t show_temp_label(struct device *dev,
+static ssize_t temp_label_show(struct device *dev,
 			       struct device_attribute *devattr,
 			       char *buf)
 {
@@ -884,7 +882,7 @@ static ssize_t show_temp_label(struct de
 	return sprintf(buf, "%s\n", temp_label(data, attr->index));
 }

-static ssize_t show_volt_max(struct device *dev,
+static ssize_t volt_max_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -898,10 +896,9 @@ static ssize_t show_volt_max(struct devi
 	return sprintf(buf, "%d\n", x);
 }

-static ssize_t set_volt_max(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t volt_max_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -926,7 +923,7 @@ static ssize_t set_volt_max(struct devic
 	return count;
 }

-static ssize_t show_volt_min(struct device *dev,
+static ssize_t volt_min_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -940,10 +937,9 @@ static ssize_t show_volt_min(struct devi
 	return sprintf(buf, "%d\n", x);
 }

-static ssize_t set_volt_min(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t volt_min_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -968,7 +964,7 @@ static ssize_t set_volt_min(struct devic
 	return count;
 }

-static ssize_t show_voltage(struct device *dev,
+static ssize_t voltage_show(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
@@ -982,7 +978,7 @@ static ssize_t show_voltage(struct devic
 	return sprintf(buf, "%d\n", x);
 }

-static ssize_t show_voltage_label(struct device *dev,
+static ssize_t voltage_label_show(struct device *dev,
 				  struct device_attribute *devattr,
 				  char *buf)
 {
@@ -992,7 +988,7 @@ static ssize_t show_voltage_label(struct
 	return sprintf(buf, "%s\n", voltage_label(data, attr->index));
 }

-static ssize_t show_alarm(struct device *dev,
+static ssize_t alarm_show(struct device *dev,
 			  struct device_attribute *devattr,
 			  char *buf)
 {
@@ -1012,7 +1008,7 @@ static int fan_enabled(struct adt7462_da
 	return data->fan_enabled & (1 << fan);
 }

-static ssize_t show_fan_min(struct device *dev,
+static ssize_t fan_min_show(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
@@ -1031,9 +1027,9 @@ static ssize_t show_fan_min(struct devic
 	return sprintf(buf, "%d\n", FAN_PERIOD_TO_RPM(temp));
 }

-static ssize_t set_fan_min(struct device *dev,
-			   struct device_attribute *devattr,
-			   const char *buf, size_t count)
+static ssize_t fan_min_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -1057,7 +1053,7 @@ static ssize_t set_fan_min(struct device
 	return count;
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
+static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -1071,7 +1067,7 @@ static ssize_t show_fan(struct device *d
 		       FAN_PERIOD_TO_RPM(data->fan[attr->index]));
 }

-static ssize_t show_force_pwm_max(struct device *dev,
+static ssize_t force_pwm_max_show(struct device *dev,
 				  struct device_attribute *devattr,
 				  char *buf)
 {
@@ -1079,10 +1075,9 @@ static ssize_t show_force_pwm_max(struct
 	return sprintf(buf, "%d\n", (data->cfg2 & ADT7462_FSPD_MASK ? 1 : 0));
 }

-static ssize_t set_force_pwm_max(struct device *dev,
-				 struct device_attribute *devattr,
-				 const char *buf,
-				 size_t count)
+static ssize_t force_pwm_max_store(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
 {
 	struct adt7462_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -1105,7 +1100,7 @@ static ssize_t set_force_pwm_max(struct
 	return count;
 }

-static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
+static ssize_t pwm_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -1113,8 +1108,8 @@ static ssize_t show_pwm(struct device *d
 	return sprintf(buf, "%d\n", data->pwm[attr->index]);
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -1134,7 +1129,7 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }

-static ssize_t show_pwm_max(struct device *dev,
+static ssize_t pwm_max_show(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
@@ -1142,10 +1137,9 @@ static ssize_t show_pwm_max(struct devic
 	return sprintf(buf, "%d\n", data->pwm_max);
 }

-static ssize_t set_pwm_max(struct device *dev,
-			   struct device_attribute *devattr,
-			   const char *buf,
-			   size_t count)
+static ssize_t pwm_max_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct adt7462_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -1164,7 +1158,7 @@ static ssize_t set_pwm_max(struct device
 	return count;
 }

-static ssize_t show_pwm_min(struct device *dev,
+static ssize_t pwm_min_show(struct device *dev,
 			    struct device_attribute *devattr,
 			    char *buf)
 {
@@ -1173,10 +1167,9 @@ static ssize_t show_pwm_min(struct devic
 	return sprintf(buf, "%d\n", data->pwm_min[attr->index]);
 }

-static ssize_t set_pwm_min(struct device *dev,
-			   struct device_attribute *devattr,
-			   const char *buf,
-			   size_t count)
+static ssize_t pwm_min_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -1197,7 +1190,7 @@ static ssize_t set_pwm_min(struct device
 	return count;
 }

-static ssize_t show_pwm_hyst(struct device *dev,
+static ssize_t pwm_hyst_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -1207,10 +1200,9 @@ static ssize_t show_pwm_hyst(struct devi
 		      (data->pwm_trange[attr->index] & ADT7462_PWM_HYST_MASK));
 }

-static ssize_t set_pwm_hyst(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t pwm_hyst_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -1236,7 +1228,7 @@ static ssize_t set_pwm_hyst(struct devic
 	return count;
 }

-static ssize_t show_pwm_tmax(struct device *dev,
+static ssize_t pwm_tmax_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -1251,10 +1243,9 @@ static ssize_t show_pwm_tmax(struct devi
 	return sprintf(buf, "%d\n", tmin + trange);
 }

-static ssize_t set_pwm_tmax(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t pwm_tmax_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	int temp;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -1284,7 +1275,7 @@ static ssize_t set_pwm_tmax(struct devic
 	return count;
 }

-static ssize_t show_pwm_tmin(struct device *dev,
+static ssize_t pwm_tmin_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -1293,10 +1284,9 @@ static ssize_t show_pwm_tmin(struct devi
 	return sprintf(buf, "%d\n", 1000 * (data->pwm_tmin[attr->index] - 64));
 }

-static ssize_t set_pwm_tmin(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t pwm_tmin_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -1318,7 +1308,7 @@ static ssize_t set_pwm_tmin(struct devic
 	return count;
 }

-static ssize_t show_pwm_auto(struct device *dev,
+static ssize_t pwm_auto_show(struct device *dev,
 			     struct device_attribute *devattr,
 			     char *buf)
 {
@@ -1350,10 +1340,9 @@ static void set_pwm_channel(struct i2c_c
 	mutex_unlock(&data->lock);
 }

-static ssize_t set_pwm_auto(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf,
-			    size_t count)
+static ssize_t pwm_auto_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -1375,7 +1364,7 @@ static ssize_t set_pwm_auto(struct devic
 	}
 }

-static ssize_t show_pwm_auto_temp(struct device *dev,
+static ssize_t pwm_auto_temp_show(struct device *dev,
 				  struct device_attribute *devattr,
 				  char *buf)
 {
@@ -1409,10 +1398,9 @@ static int cvt_auto_temp(int input)
 	return ilog2(input);
 }

-static ssize_t set_pwm_auto_temp(struct device *dev,
-				 struct device_attribute *devattr,
-				 const char *buf,
-				 size_t count)
+static ssize_t pwm_auto_temp_store(struct device *dev,
+				   struct device_attribute *devattr,
+				   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct adt7462_data *data = dev_get_drvdata(dev);
@@ -1431,274 +1419,199 @@ static ssize_t set_pwm_auto_temp(struct
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 1);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 2);
-static SENSOR_DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_max,
-		    set_temp_max, 3);
-
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 0);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 1);
-static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 2);
-static SENSOR_DEVICE_ATTR(temp4_min, S_IWUSR | S_IRUGO, show_temp_min,
-		    set_temp_min, 3);
-
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 3);
-
-static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_temp_label, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_temp_label, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_label, S_IRUGO, show_temp_label, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_label, S_IRUGO, show_temp_label, NULL, 3);
-
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM1 | ADT7462_LT_ALARM);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM1 | ADT7462_R1T_ALARM);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM1 | ADT7462_R2T_ALARM);
-static SENSOR_DEVICE_ATTR(temp4_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM1 | ADT7462_R3T_ALARM);
-
-static SENSOR_DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 0);
-static SENSOR_DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 1);
-static SENSOR_DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 2);
-static SENSOR_DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 3);
-static SENSOR_DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 4);
-static SENSOR_DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 5);
-static SENSOR_DEVICE_ATTR(in7_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 6);
-static SENSOR_DEVICE_ATTR(in8_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 7);
-static SENSOR_DEVICE_ATTR(in9_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 8);
-static SENSOR_DEVICE_ATTR(in10_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 9);
-static SENSOR_DEVICE_ATTR(in11_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 10);
-static SENSOR_DEVICE_ATTR(in12_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 11);
-static SENSOR_DEVICE_ATTR(in13_max, S_IWUSR | S_IRUGO, show_volt_max,
-		    set_volt_max, 12);
-
-static SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 0);
-static SENSOR_DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 1);
-static SENSOR_DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 2);
-static SENSOR_DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 3);
-static SENSOR_DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 4);
-static SENSOR_DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 5);
-static SENSOR_DEVICE_ATTR(in7_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 6);
-static SENSOR_DEVICE_ATTR(in8_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 7);
-static SENSOR_DEVICE_ATTR(in9_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 8);
-static SENSOR_DEVICE_ATTR(in10_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 9);
-static SENSOR_DEVICE_ATTR(in11_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 10);
-static SENSOR_DEVICE_ATTR(in12_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 11);
-static SENSOR_DEVICE_ATTR(in13_min, S_IWUSR | S_IRUGO, show_volt_min,
-		    set_volt_min, 12);
-
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_voltage, NULL, 0);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_voltage, NULL, 1);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_voltage, NULL, 2);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_voltage, NULL, 3);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_voltage, NULL, 4);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_voltage, NULL, 5);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_voltage, NULL, 6);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, show_voltage, NULL, 7);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, show_voltage, NULL, 8);
-static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, show_voltage, NULL, 9);
-static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, show_voltage, NULL, 10);
-static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, show_voltage, NULL, 11);
-static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, show_voltage, NULL, 12);
-
-static SENSOR_DEVICE_ATTR(in1_label, S_IRUGO, show_voltage_label, NULL, 0);
-static SENSOR_DEVICE_ATTR(in2_label, S_IRUGO, show_voltage_label, NULL, 1);
-static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_voltage_label, NULL, 2);
-static SENSOR_DEVICE_ATTR(in4_label, S_IRUGO, show_voltage_label, NULL, 3);
-static SENSOR_DEVICE_ATTR(in5_label, S_IRUGO, show_voltage_label, NULL, 4);
-static SENSOR_DEVICE_ATTR(in6_label, S_IRUGO, show_voltage_label, NULL, 5);
-static SENSOR_DEVICE_ATTR(in7_label, S_IRUGO, show_voltage_label, NULL, 6);
-static SENSOR_DEVICE_ATTR(in8_label, S_IRUGO, show_voltage_label, NULL, 7);
-static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, show_voltage_label, NULL, 8);
-static SENSOR_DEVICE_ATTR(in10_label, S_IRUGO, show_voltage_label, NULL, 9);
-static SENSOR_DEVICE_ATTR(in11_label, S_IRUGO, show_voltage_label, NULL, 10);
-static SENSOR_DEVICE_ATTR(in12_label, S_IRUGO, show_voltage_label, NULL, 11);
-static SENSOR_DEVICE_ATTR(in13_label, S_IRUGO, show_voltage_label, NULL, 12);
-
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM2 | ADT7462_V0_ALARM);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM2 | ADT7462_V7_ALARM);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM2 | ADT7462_V2_ALARM);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM2 | ADT7462_V6_ALARM);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM2 | ADT7462_V5_ALARM);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM2 | ADT7462_V4_ALARM);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM2 | ADT7462_V3_ALARM);
-static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM2 | ADT7462_V1_ALARM);
-static SENSOR_DEVICE_ATTR(in9_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM3 | ADT7462_V10_ALARM);
-static SENSOR_DEVICE_ATTR(in10_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM3 | ADT7462_V9_ALARM);
-static SENSOR_DEVICE_ATTR(in11_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM3 | ADT7462_V8_ALARM);
-static SENSOR_DEVICE_ATTR(in12_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM3 | ADT7462_V11_ALARM);
-static SENSOR_DEVICE_ATTR(in13_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM3 | ADT7462_V12_ALARM);
-
-static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 2);
-static SENSOR_DEVICE_ATTR(fan4_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 3);
-static SENSOR_DEVICE_ATTR(fan5_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 4);
-static SENSOR_DEVICE_ATTR(fan6_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 5);
-static SENSOR_DEVICE_ATTR(fan7_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 6);
-static SENSOR_DEVICE_ATTR(fan8_min, S_IWUSR | S_IRUGO, show_fan_min,
-		    set_fan_min, 7);
-
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3);
-static SENSOR_DEVICE_ATTR(fan5_input, S_IRUGO, show_fan, NULL, 4);
-static SENSOR_DEVICE_ATTR(fan6_input, S_IRUGO, show_fan, NULL, 5);
-static SENSOR_DEVICE_ATTR(fan7_input, S_IRUGO, show_fan, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan8_input, S_IRUGO, show_fan, NULL, 7);
-
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM4 | ADT7462_F0_ALARM);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM4 | ADT7462_F1_ALARM);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM4 | ADT7462_F2_ALARM);
-static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM4 | ADT7462_F3_ALARM);
-static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM4 | ADT7462_F4_ALARM);
-static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM4 | ADT7462_F5_ALARM);
-static SENSOR_DEVICE_ATTR(fan7_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM4 | ADT7462_F6_ALARM);
-static SENSOR_DEVICE_ATTR(fan8_alarm, S_IRUGO, show_alarm, NULL,
-			  ADT7462_ALARM4 | ADT7462_F7_ALARM);
-
-static SENSOR_DEVICE_ATTR(force_pwm_max, S_IWUSR | S_IRUGO,
-		    show_force_pwm_max, set_force_pwm_max, 0);
-
-static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1);
-static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2);
-static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 3);
-
-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 1);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 2);
-static SENSOR_DEVICE_ATTR(pwm4_auto_point1_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_min, set_pwm_min, 3);
-
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 1);
-static SENSOR_DEVICE_ATTR(pwm3_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 2);
-static SENSOR_DEVICE_ATTR(pwm4_auto_point2_pwm, S_IWUSR | S_IRUGO,
-		    show_pwm_max, set_pwm_max, 3);
-
-static SENSOR_DEVICE_ATTR(temp1_auto_point1_hyst, S_IWUSR | S_IRUGO,
-		    show_pwm_hyst, set_pwm_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp2_auto_point1_hyst, S_IWUSR | S_IRUGO,
-		    show_pwm_hyst, set_pwm_hyst, 1);
-static SENSOR_DEVICE_ATTR(temp3_auto_point1_hyst, S_IWUSR | S_IRUGO,
-		    show_pwm_hyst, set_pwm_hyst, 2);
-static SENSOR_DEVICE_ATTR(temp4_auto_point1_hyst, S_IWUSR | S_IRUGO,
-		    show_pwm_hyst, set_pwm_hyst, 3);
-
-static SENSOR_DEVICE_ATTR(temp1_auto_point2_hyst, S_IWUSR | S_IRUGO,
-		    show_pwm_hyst, set_pwm_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp2_auto_point2_hyst, S_IWUSR | S_IRUGO,
-		    show_pwm_hyst, set_pwm_hyst, 1);
-static SENSOR_DEVICE_ATTR(temp3_auto_point2_hyst, S_IWUSR | S_IRUGO,
-		    show_pwm_hyst, set_pwm_hyst, 2);
-static SENSOR_DEVICE_ATTR(temp4_auto_point2_hyst, S_IWUSR | S_IRUGO,
-		    show_pwm_hyst, set_pwm_hyst, 3);
-
-static SENSOR_DEVICE_ATTR(temp1_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 0);
-static SENSOR_DEVICE_ATTR(temp2_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 1);
-static SENSOR_DEVICE_ATTR(temp3_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 2);
-static SENSOR_DEVICE_ATTR(temp4_auto_point1_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmin, set_pwm_tmin, 3);
-
-static SENSOR_DEVICE_ATTR(temp1_auto_point2_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmax, set_pwm_tmax, 0);
-static SENSOR_DEVICE_ATTR(temp2_auto_point2_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmax, set_pwm_tmax, 1);
-static SENSOR_DEVICE_ATTR(temp3_auto_point2_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmax, set_pwm_tmax, 2);
-static SENSOR_DEVICE_ATTR(temp4_auto_point2_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_tmax, set_pwm_tmax, 3);
-
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 0);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 1);
-static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 2);
-static SENSOR_DEVICE_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_auto,
-		    set_pwm_auto, 3);
-
-static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 0);
-static SENSOR_DEVICE_ATTR(pwm2_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 1);
-static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 2);
-static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO,
-		    show_pwm_auto_temp, set_pwm_auto_temp, 3);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, temp_max, 2);
+static SENSOR_DEVICE_ATTR_RW(temp4_max, temp_max, 3);
+
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp_min, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_min, temp_min, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_min, temp_min, 2);
+static SENSOR_DEVICE_ATTR_RW(temp4_min, temp_min, 3);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 3);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_label, temp_label, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_label, temp_label, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_label, temp_label, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_label, temp_label, 3);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm,
+			     ADT7462_ALARM1 | ADT7462_LT_ALARM);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm,
+			     ADT7462_ALARM1 | ADT7462_R1T_ALARM);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm,
+			     ADT7462_ALARM1 | ADT7462_R2T_ALARM);
+static SENSOR_DEVICE_ATTR_RO(temp4_alarm, alarm,
+			     ADT7462_ALARM1 | ADT7462_R3T_ALARM);
+
+static SENSOR_DEVICE_ATTR_RW(in1_max, volt_max, 0);
+static SENSOR_DEVICE_ATTR_RW(in2_max, volt_max, 1);
+static SENSOR_DEVICE_ATTR_RW(in3_max, volt_max, 2);
+static SENSOR_DEVICE_ATTR_RW(in4_max, volt_max, 3);
+static SENSOR_DEVICE_ATTR_RW(in5_max, volt_max, 4);
+static SENSOR_DEVICE_ATTR_RW(in6_max, volt_max, 5);
+static SENSOR_DEVICE_ATTR_RW(in7_max, volt_max, 6);
+static SENSOR_DEVICE_ATTR_RW(in8_max, volt_max, 7);
+static SENSOR_DEVICE_ATTR_RW(in9_max, volt_max, 8);
+static SENSOR_DEVICE_ATTR_RW(in10_max, volt_max, 9);
+static SENSOR_DEVICE_ATTR_RW(in11_max, volt_max, 10);
+static SENSOR_DEVICE_ATTR_RW(in12_max, volt_max, 11);
+static SENSOR_DEVICE_ATTR_RW(in13_max, volt_max, 12);
+
+static SENSOR_DEVICE_ATTR_RW(in1_min, volt_min, 0);
+static SENSOR_DEVICE_ATTR_RW(in2_min, volt_min, 1);
+static SENSOR_DEVICE_ATTR_RW(in3_min, volt_min, 2);
+static SENSOR_DEVICE_ATTR_RW(in4_min, volt_min, 3);
+static SENSOR_DEVICE_ATTR_RW(in5_min, volt_min, 4);
+static SENSOR_DEVICE_ATTR_RW(in6_min, volt_min, 5);
+static SENSOR_DEVICE_ATTR_RW(in7_min, volt_min, 6);
+static SENSOR_DEVICE_ATTR_RW(in8_min, volt_min, 7);
+static SENSOR_DEVICE_ATTR_RW(in9_min, volt_min, 8);
+static SENSOR_DEVICE_ATTR_RW(in10_min, volt_min, 9);
+static SENSOR_DEVICE_ATTR_RW(in11_min, volt_min, 10);
+static SENSOR_DEVICE_ATTR_RW(in12_min, volt_min, 11);
+static SENSOR_DEVICE_ATTR_RW(in13_min, volt_min, 12);
+
+static SENSOR_DEVICE_ATTR_RO(in1_input, voltage, 0);
+static SENSOR_DEVICE_ATTR_RO(in2_input, voltage, 1);
+static SENSOR_DEVICE_ATTR_RO(in3_input, voltage, 2);
+static SENSOR_DEVICE_ATTR_RO(in4_input, voltage, 3);
+static SENSOR_DEVICE_ATTR_RO(in5_input, voltage, 4);
+static SENSOR_DEVICE_ATTR_RO(in6_input, voltage, 5);
+static SENSOR_DEVICE_ATTR_RO(in7_input, voltage, 6);
+static SENSOR_DEVICE_ATTR_RO(in8_input, voltage, 7);
+static SENSOR_DEVICE_ATTR_RO(in9_input, voltage, 8);
+static SENSOR_DEVICE_ATTR_RO(in10_input, voltage, 9);
+static SENSOR_DEVICE_ATTR_RO(in11_input, voltage, 10);
+static SENSOR_DEVICE_ATTR_RO(in12_input, voltage, 11);
+static SENSOR_DEVICE_ATTR_RO(in13_input, voltage, 12);
+
+static SENSOR_DEVICE_ATTR_RO(in1_label, voltage_label, 0);
+static SENSOR_DEVICE_ATTR_RO(in2_label, voltage_label, 1);
+static SENSOR_DEVICE_ATTR_RO(in3_label, voltage_label, 2);
+static SENSOR_DEVICE_ATTR_RO(in4_label, voltage_label, 3);
+static SENSOR_DEVICE_ATTR_RO(in5_label, voltage_label, 4);
+static SENSOR_DEVICE_ATTR_RO(in6_label, voltage_label, 5);
+static SENSOR_DEVICE_ATTR_RO(in7_label, voltage_label, 6);
+static SENSOR_DEVICE_ATTR_RO(in8_label, voltage_label, 7);
+static SENSOR_DEVICE_ATTR_RO(in9_label, voltage_label, 8);
+static SENSOR_DEVICE_ATTR_RO(in10_label, voltage_label, 9);
+static SENSOR_DEVICE_ATTR_RO(in11_label, voltage_label, 10);
+static SENSOR_DEVICE_ATTR_RO(in12_label, voltage_label, 11);
+static SENSOR_DEVICE_ATTR_RO(in13_label, voltage_label, 12);
+
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm,
+			     ADT7462_ALARM2 | ADT7462_V0_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm,
+			     ADT7462_ALARM2 | ADT7462_V7_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm,
+			     ADT7462_ALARM2 | ADT7462_V2_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm,
+			     ADT7462_ALARM2 | ADT7462_V6_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm,
+			     ADT7462_ALARM2 | ADT7462_V5_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm,
+			     ADT7462_ALARM2 | ADT7462_V4_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, alarm,
+			     ADT7462_ALARM2 | ADT7462_V3_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in8_alarm, alarm,
+			     ADT7462_ALARM2 | ADT7462_V1_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in9_alarm, alarm,
+			     ADT7462_ALARM3 | ADT7462_V10_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in10_alarm, alarm,
+			     ADT7462_ALARM3 | ADT7462_V9_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in11_alarm, alarm,
+			     ADT7462_ALARM3 | ADT7462_V8_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in12_alarm, alarm,
+			     ADT7462_ALARM3 | ADT7462_V11_ALARM);
+static SENSOR_DEVICE_ATTR_RO(in13_alarm, alarm,
+			     ADT7462_ALARM3 | ADT7462_V12_ALARM);
+
+static SENSOR_DEVICE_ATTR_RW(fan1_min, fan_min, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_min, fan_min, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_min, fan_min, 2);
+static SENSOR_DEVICE_ATTR_RW(fan4_min, fan_min, 3);
+static SENSOR_DEVICE_ATTR_RW(fan5_min, fan_min, 4);
+static SENSOR_DEVICE_ATTR_RW(fan6_min, fan_min, 5);
+static SENSOR_DEVICE_ATTR_RW(fan7_min, fan_min, 6);
+static SENSOR_DEVICE_ATTR_RW(fan8_min, fan_min, 7);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan, 3);
+static SENSOR_DEVICE_ATTR_RO(fan5_input, fan, 4);
+static SENSOR_DEVICE_ATTR_RO(fan6_input, fan, 5);
+static SENSOR_DEVICE_ATTR_RO(fan7_input, fan, 6);
+static SENSOR_DEVICE_ATTR_RO(fan8_input, fan, 7);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm,
+			     ADT7462_ALARM4 | ADT7462_F0_ALARM);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm,
+			     ADT7462_ALARM4 | ADT7462_F1_ALARM);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm,
+			     ADT7462_ALARM4 | ADT7462_F2_ALARM);
+static SENSOR_DEVICE_ATTR_RO(fan4_alarm, alarm,
+			     ADT7462_ALARM4 | ADT7462_F3_ALARM);
+static SENSOR_DEVICE_ATTR_RO(fan5_alarm, alarm,
+			     ADT7462_ALARM4 | ADT7462_F4_ALARM);
+static SENSOR_DEVICE_ATTR_RO(fan6_alarm, alarm,
+			     ADT7462_ALARM4 | ADT7462_F5_ALARM);
+static SENSOR_DEVICE_ATTR_RO(fan7_alarm, alarm,
+			     ADT7462_ALARM4 | ADT7462_F6_ALARM);
+static SENSOR_DEVICE_ATTR_RO(fan8_alarm, alarm,
+			     ADT7462_ALARM4 | ADT7462_F7_ALARM);
+
+static SENSOR_DEVICE_ATTR_RW(force_pwm_max, force_pwm_max, 0);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4, pwm, 3);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point1_pwm, pwm_min, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point1_pwm, pwm_min, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point1_pwm, pwm_min, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_auto_point1_pwm, pwm_min, 3);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm_max, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_point2_pwm, pwm_max, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_point2_pwm, pwm_max, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_auto_point2_pwm, pwm_max, 3);
+
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_point1_hyst, pwm_hyst, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_auto_point1_hyst, pwm_hyst, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_auto_point1_hyst, pwm_hyst, 2);
+static SENSOR_DEVICE_ATTR_RW(temp4_auto_point1_hyst, pwm_hyst, 3);
+
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_point2_hyst, pwm_hyst, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_auto_point2_hyst, pwm_hyst, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_auto_point2_hyst, pwm_hyst, 2);
+static SENSOR_DEVICE_ATTR_RW(temp4_auto_point2_hyst, pwm_hyst, 3);
+
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_point1_temp, pwm_tmin, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_auto_point1_temp, pwm_tmin, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_auto_point1_temp, pwm_tmin, 2);
+static SENSOR_DEVICE_ATTR_RW(temp4_auto_point1_temp, pwm_tmin, 3);
+
+static SENSOR_DEVICE_ATTR_RW(temp1_auto_point2_temp, pwm_tmax, 0);
+static SENSOR_DEVICE_ATTR_RW(temp2_auto_point2_temp, pwm_tmax, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_auto_point2_temp, pwm_tmax, 2);
+static SENSOR_DEVICE_ATTR_RW(temp4_auto_point2_temp, pwm_tmax, 3);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_auto, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_auto, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwm_auto, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_enable, pwm_auto, 3);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_channels_temp, pwm_auto_temp, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_auto_channels_temp, pwm_auto_temp, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_auto_channels_temp, pwm_auto_temp, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_auto_channels_temp, pwm_auto_temp, 3);

 static struct attribute *adt7462_attrs[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
diff -u -p a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
--- a/drivers/hwmon/ltc4215.c
+++ b/drivers/hwmon/ltc4215.c
@@ -136,7 +136,7 @@ static unsigned int ltc4215_get_current(
 	return curr;
 }

-static ssize_t ltc4215_show_voltage(struct device *dev,
+static ssize_t ltc4215_voltage_show(struct device *dev,
 				    struct device_attribute *da,
 				    char *buf)
 {
@@ -146,7 +146,7 @@ static ssize_t ltc4215_show_voltage(stru
 	return snprintf(buf, PAGE_SIZE, "%d\n", voltage);
 }

-static ssize_t ltc4215_show_current(struct device *dev,
+static ssize_t ltc4215_current_show(struct device *dev,
 				    struct device_attribute *da,
 				    char *buf)
 {
@@ -155,7 +155,7 @@ static ssize_t ltc4215_show_current(stru
 	return snprintf(buf, PAGE_SIZE, "%u\n", curr);
 }

-static ssize_t ltc4215_show_power(struct device *dev,
+static ssize_t ltc4215_power_show(struct device *dev,
 				  struct device_attribute *da,
 				  char *buf)
 {
@@ -168,7 +168,7 @@ static ssize_t ltc4215_show_power(struct
 	return snprintf(buf, PAGE_SIZE, "%u\n", power);
 }

-static ssize_t ltc4215_show_alarm(struct device *dev,
+static ssize_t ltc4215_alarm_show(struct device *dev,
 					  struct device_attribute *da,
 					  char *buf)
 {
@@ -189,26 +189,20 @@ static ssize_t ltc4215_show_alarm(struct
 /* Construct a sensor_device_attribute structure for each register */

 /* Current */
-static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, ltc4215_show_current, NULL, 0);
-static SENSOR_DEVICE_ATTR(curr1_max_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
-			  1 << 2);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, ltc4215_current, 0);
+static SENSOR_DEVICE_ATTR_RO(curr1_max_alarm, ltc4215_alarm, 1 << 2);

 /* Power (virtual) */
-static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, ltc4215_show_power, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(power1_input, ltc4215_power, 0);

 /* Input Voltage */
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, ltc4215_show_voltage, NULL,
-			  LTC4215_ADIN);
-static SENSOR_DEVICE_ATTR(in1_max_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
-			  1 << 0);
-static SENSOR_DEVICE_ATTR(in1_min_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
-			  1 << 1);
+static SENSOR_DEVICE_ATTR_RO(in1_input, ltc4215_voltage, LTC4215_ADIN);
+static SENSOR_DEVICE_ATTR_RO(in1_max_alarm, ltc4215_alarm, 1 << 0);
+static SENSOR_DEVICE_ATTR_RO(in1_min_alarm, ltc4215_alarm, 1 << 1);

 /* Output Voltage */
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, ltc4215_show_voltage, NULL,
-			  LTC4215_SOURCE);
-static SENSOR_DEVICE_ATTR(in2_min_alarm, S_IRUGO, ltc4215_show_alarm, NULL,
-			  1 << 3);
+static SENSOR_DEVICE_ATTR_RO(in2_input, ltc4215_voltage, LTC4215_SOURCE);
+static SENSOR_DEVICE_ATTR_RO(in2_min_alarm, ltc4215_alarm, 1 << 3);

 /*
  * Finally, construct an array of pointers to members of the above objects,
diff -u -p a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -277,10 +277,8 @@ static struct amc6821_data *amc6821_upda
 	return data;
 }

-static ssize_t get_temp(
-		struct device *dev,
-		struct device_attribute *devattr,
-		char *buf)
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
 	int ix = to_sensor_dev_attr(devattr)->index;
@@ -288,11 +286,8 @@ static ssize_t get_temp(
 	return sprintf(buf, "%d\n", data->temp[ix] * 1000);
 }

-static ssize_t set_temp(
-		struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t count)
+static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -314,10 +309,8 @@ static ssize_t set_temp(
 	return count;
 }

-static ssize_t get_temp_alarm(
-	struct device *dev,
-	struct device_attribute *devattr,
-	char *buf)
+static ssize_t temp_alarm_show(struct device *dev,
+		               struct device_attribute *devattr, char *buf)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
 	int ix = to_sensor_dev_attr(devattr)->index;
@@ -352,10 +345,8 @@ static ssize_t get_temp_alarm(
 		return sprintf(buf, "0");
 }

-static ssize_t get_temp2_fault(
-		struct device *dev,
-		struct device_attribute *devattr,
-		char *buf)
+static ssize_t temp2_fault_show(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
 	if (data->stat1 & AMC6821_STAT1_RTF)
@@ -364,20 +355,16 @@ static ssize_t get_temp2_fault(
 		return sprintf(buf, "0");
 }

-static ssize_t get_pwm1(
-		struct device *dev,
-		struct device_attribute *devattr,
-		char *buf)
+static ssize_t pwm1_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1);
 }

-static ssize_t set_pwm1(
-		struct device *dev,
-		struct device_attribute *devattr,
-		const char *buf,
-		size_t count)
+static ssize_t pwm1_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -393,20 +380,16 @@ static ssize_t set_pwm1(
 	return count;
 }

-static ssize_t get_pwm1_enable(
-		struct device *dev,
-		struct device_attribute *devattr,
-		char *buf)
+static ssize_t pwm1_enable_show(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1_enable);
 }

-static ssize_t set_pwm1_enable(
-		struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t count)
+static ssize_t pwm1_enable_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -451,19 +434,17 @@ unlock:
 	return count;
 }

-static ssize_t get_pwm1_auto_channels_temp(
-		struct device *dev,
-		struct device_attribute *devattr,
-		char *buf)
+static ssize_t pwm1_auto_channels_temp_show(struct device *dev,
+					    struct device_attribute *devattr,
+					    char *buf)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1_auto_channels_temp);
 }

-static ssize_t get_temp_auto_point_temp(
-		struct device *dev,
-		struct device_attribute *devattr,
-		char *buf)
+static ssize_t temp_auto_point_temp_show(struct device *dev,
+					 struct device_attribute *devattr,
+					 char *buf)
 {
 	int ix = to_sensor_dev_attr_2(devattr)->index;
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
@@ -481,10 +462,9 @@ static ssize_t get_temp_auto_point_temp(
 	}
 }

-static ssize_t get_pwm1_auto_point_pwm(
-		struct device *dev,
-		struct device_attribute *devattr,
-		char *buf)
+static ssize_t pwm1_auto_point_pwm_show(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
 {
 	int ix = to_sensor_dev_attr(devattr)->index;
 	struct amc6821_data *data = amc6821_update_device(dev);
@@ -513,11 +493,9 @@ static inline ssize_t set_slope_register
 	return 0;
 }

-static ssize_t set_temp_auto_point_temp(
-		struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t count)
+static ssize_t temp_auto_point_temp_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
 	struct i2c_client *client = data->client;
@@ -586,11 +564,9 @@ EXIT:
 	return count;
 }

-static ssize_t set_pwm1_auto_point_pwm(
-		struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t count)
+static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -626,10 +602,8 @@ EXIT:
 	return count;
 }

-static ssize_t get_fan(
-		struct device *dev,
-		struct device_attribute *devattr,
-		char *buf)
+static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
+			char *buf)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
 	int ix = to_sensor_dev_attr(devattr)->index;
@@ -638,10 +612,8 @@ static ssize_t get_fan(
 	return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
 }

-static ssize_t get_fan1_fault(
-		struct device *dev,
-		struct device_attribute *devattr,
-		char *buf)
+static ssize_t fan1_fault_show(struct device *dev,
+		               struct device_attribute *devattr, char *buf)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
 	if (data->stat1 & AMC6821_STAT1_FANS)
@@ -650,10 +622,8 @@ static ssize_t get_fan1_fault(
 		return sprintf(buf, "0");
 }

-static ssize_t set_fan(
-		struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -682,19 +652,16 @@ EXIT:
 	return count;
 }

-static ssize_t get_fan1_div(
-		struct device *dev,
-		struct device_attribute *devattr,
-		char *buf)
+static ssize_t fan1_div_show(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
 	return sprintf(buf, "%d\n", data->fan1_div);
 }

-static ssize_t set_fan1_div(
-		struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t fan1_div_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -734,69 +701,47 @@ EXIT:
 	return count;
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
-	get_temp, NULL, IDX_TEMP1_INPUT);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR, get_temp,
-	set_temp, IDX_TEMP1_MIN);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR, get_temp,
-	set_temp, IDX_TEMP1_MAX);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO | S_IWUSR, get_temp,
-	set_temp, IDX_TEMP1_CRIT);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO,
-	get_temp_alarm, NULL, IDX_TEMP1_MIN);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO,
-	get_temp_alarm, NULL, IDX_TEMP1_MAX);
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO,
-	get_temp_alarm, NULL, IDX_TEMP1_CRIT);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO,
-	get_temp, NULL, IDX_TEMP2_INPUT);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO | S_IWUSR, get_temp,
-	set_temp, IDX_TEMP2_MIN);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR, get_temp,
-	set_temp, IDX_TEMP2_MAX);
-static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO | S_IWUSR, get_temp,
-	set_temp, IDX_TEMP2_CRIT);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO,
-	get_temp2_fault, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO,
-	get_temp_alarm, NULL, IDX_TEMP2_MIN);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO,
-	get_temp_alarm, NULL, IDX_TEMP2_MAX);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO,
-	get_temp_alarm, NULL, IDX_TEMP2_CRIT);
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, get_fan, NULL, IDX_FAN1_INPUT);
-static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO | S_IWUSR,
-	get_fan, set_fan, IDX_FAN1_MIN);
-static SENSOR_DEVICE_ATTR(fan1_max, S_IRUGO | S_IWUSR,
-	get_fan, set_fan, IDX_FAN1_MAX);
-static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, get_fan1_fault, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
-	get_fan1_div, set_fan1_div, 0);
-
-static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm1, set_pwm1, 0);
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
-	get_pwm1_enable, set_pwm1_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IRUGO,
-	get_pwm1_auto_point_pwm, NULL, 0);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point2_pwm, S_IWUSR | S_IRUGO,
-	get_pwm1_auto_point_pwm, set_pwm1_auto_point_pwm, 1);
-static SENSOR_DEVICE_ATTR(pwm1_auto_point3_pwm, S_IRUGO,
-	get_pwm1_auto_point_pwm, NULL, 2);
-static SENSOR_DEVICE_ATTR(pwm1_auto_channels_temp, S_IRUGO,
-	get_pwm1_auto_channels_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_point1_temp, S_IRUGO,
-	get_temp_auto_point_temp, NULL, 1, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_point2_temp, S_IWUSR | S_IRUGO,
-	get_temp_auto_point_temp, set_temp_auto_point_temp, 1, 1);
-static SENSOR_DEVICE_ATTR_2(temp1_auto_point3_temp, S_IWUSR | S_IRUGO,
-	get_temp_auto_point_temp, set_temp_auto_point_temp, 1, 2);
-
-static SENSOR_DEVICE_ATTR_2(temp2_auto_point1_temp, S_IWUSR | S_IRUGO,
-	get_temp_auto_point_temp, set_temp_auto_point_temp, 2, 0);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_point2_temp, S_IWUSR | S_IRUGO,
-	get_temp_auto_point_temp, set_temp_auto_point_temp, 2, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_auto_point3_temp, S_IWUSR | S_IRUGO,
-	get_temp_auto_point_temp, set_temp_auto_point_temp, 2, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, IDX_TEMP1_INPUT);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp, IDX_TEMP1_MIN);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, IDX_TEMP1_MAX);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp, IDX_TEMP1_CRIT);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, temp_alarm, IDX_TEMP1_MIN);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, temp_alarm, IDX_TEMP1_MAX);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, temp_alarm, IDX_TEMP1_CRIT);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, IDX_TEMP2_INPUT);
+static SENSOR_DEVICE_ATTR_RW(temp2_min, temp, IDX_TEMP2_MIN);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp, IDX_TEMP2_MAX);
+static SENSOR_DEVICE_ATTR_RW(temp2_crit, temp, IDX_TEMP2_CRIT);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp2_fault, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, temp_alarm, IDX_TEMP2_MIN);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, temp_alarm, IDX_TEMP2_MAX);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, temp_alarm, IDX_TEMP2_CRIT);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, IDX_FAN1_INPUT);
+static SENSOR_DEVICE_ATTR_RW(fan1_min, fan, IDX_FAN1_MIN);
+static SENSOR_DEVICE_ATTR_RW(fan1_max, fan, IDX_FAN1_MAX);
+static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan1_fault, 0);
+static SENSOR_DEVICE_ATTR_RW(fan1_div, fan1_div, 0);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm1, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm1_enable, 0);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_pwm, pwm1_auto_point_pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm1_auto_point_pwm, 1);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point3_pwm, pwm1_auto_point_pwm, 2);
+static SENSOR_DEVICE_ATTR_RO(pwm1_auto_channels_temp, pwm1_auto_channels_temp,
+			     0);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_auto_point1_temp, temp_auto_point_temp,
+			       1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_point2_temp, temp_auto_point_temp,
+			       1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_point3_temp, temp_auto_point_temp,
+			       1, 2);
+
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_point1_temp, temp_auto_point_temp,
+			       2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_point2_temp, temp_auto_point_temp,
+			       2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_point3_temp, temp_auto_point_temp,
+			       2, 2);

 static struct attribute *amc6821_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -249,7 +249,7 @@ abort:
 	return ret;
 }

-static ssize_t show_temp_input(struct device *dev,
+static ssize_t temp_input_show(struct device *dev,
 			       struct device_attribute *devattr, char *buf)
 {
 	int index = to_sensor_dev_attr(devattr)->index;
@@ -265,7 +265,7 @@ static ssize_t show_temp_input(struct de
 	return sprintf(buf, "%d\n", temp * 125);
 }

-static ssize_t show_temp(struct device *dev,
+static ssize_t temp_show(struct device *dev,
 			 struct device_attribute *devattr, char *buf)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
@@ -282,7 +282,7 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", temp * 1000);
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int index = to_sensor_dev_attr(attr)->index;
@@ -297,9 +297,9 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (data->alarms >> index) & 0x1);
 }

-static ssize_t set_temp(struct device *dev,
-			struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
 	int index = to_sensor_dev_attr_2(devattr)->index;
@@ -324,79 +324,63 @@ static ssize_t set_temp(struct device *d
 	return ret < 0 ? ret : count;
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
-static SENSOR_DEVICE_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    0, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    0, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input, NULL, 1);
-static SENSOR_DEVICE_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    1, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    1, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input, NULL, 2);
-static SENSOR_DEVICE_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    2, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    2, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_input, NULL, 3);
-static SENSOR_DEVICE_ATTR_2(temp4_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    3, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp4_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    3, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp_input, NULL, 4);
-static SENSOR_DEVICE_ATTR_2(temp5_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    4, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp5_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    4, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp_input, NULL, 5);
-static SENSOR_DEVICE_ATTR_2(temp6_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    5, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp6_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    5, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp7_input, S_IRUGO, show_temp_input, NULL, 6);
-static SENSOR_DEVICE_ATTR_2(temp7_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    6, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp7_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    6, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, show_temp_input, NULL, 7);
-static SENSOR_DEVICE_ATTR_2(temp8_max, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    7, MAX6697_TEMP_MAX);
-static SENSOR_DEVICE_ATTR_2(temp8_crit, S_IRUGO | S_IWUSR, show_temp, set_temp,
-			    7, MAX6697_TEMP_CRIT);
-
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 22);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 16);
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO, show_alarm, NULL, 17);
-static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_alarm, NULL, 18);
-static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO, show_alarm, NULL, 19);
-static SENSOR_DEVICE_ATTR(temp6_max_alarm, S_IRUGO, show_alarm, NULL, 20);
-static SENSOR_DEVICE_ATTR(temp7_max_alarm, S_IRUGO, show_alarm, NULL, 21);
-static SENSOR_DEVICE_ATTR(temp8_max_alarm, S_IRUGO, show_alarm, NULL, 23);
-
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 14);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(temp4_crit_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(temp5_crit_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp6_crit_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(temp7_crit_alarm, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(temp8_crit_alarm, S_IRUGO, show_alarm, NULL, 15);
-
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_fault, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp7_fault, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(temp8_fault, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_input, 1);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_max, temp, 1, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp2_crit, temp, 1, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp_input, 2);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_max, temp, 2, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp3_crit, temp, 2, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp_input, 3);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_max, temp, 3, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp4_crit, temp, 3, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp5_input, temp_input, 4);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_max, temp, 4, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp5_crit, temp, 4, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp6_input, temp_input, 5);
+static SENSOR_DEVICE_ATTR_2_RW(temp6_max, temp, 5, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp6_crit, temp, 5, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp7_input, temp_input, 6);
+static SENSOR_DEVICE_ATTR_2_RW(temp7_max, temp, 6, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp7_crit, temp, 6, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp8_input, temp_input, 7);
+static SENSOR_DEVICE_ATTR_2_RW(temp8_max, temp, 7, MAX6697_TEMP_MAX);
+static SENSOR_DEVICE_ATTR_2_RW(temp8_crit, temp, 7, MAX6697_TEMP_CRIT);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 22);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 16);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, alarm, 17);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_alarm, alarm, 18);
+static SENSOR_DEVICE_ATTR_RO(temp5_max_alarm, alarm, 19);
+static SENSOR_DEVICE_ATTR_RO(temp6_max_alarm, alarm, 20);
+static SENSOR_DEVICE_ATTR_RO(temp7_max_alarm, alarm, 21);
+static SENSOR_DEVICE_ATTR_RO(temp8_max_alarm, alarm, 23);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 14);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(temp4_crit_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(temp5_crit_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp6_crit_alarm, alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(temp7_crit_alarm, alarm, 13);
+static SENSOR_DEVICE_ATTR_RO(temp8_crit_alarm, alarm, 15);
+
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_fault, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_fault, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_fault, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp7_fault, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(temp8_fault, alarm, 7);

 static DEVICE_ATTR(dummy, 0, NULL, NULL);

diff -u -p a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -423,7 +423,7 @@ static struct f71805f_data *f71805f_upda
  * Sysfs interface
  */

-static ssize_t show_in0(struct device *dev, struct device_attribute *devattr,
+static ssize_t in0_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -433,7 +433,7 @@ static ssize_t show_in0(struct device *d
 	return sprintf(buf, "%ld\n", in0_from_reg(data->in[nr]));
 }

-static ssize_t show_in0_max(struct device *dev, struct device_attribute
+static ssize_t in0_max_show(struct device *dev, struct device_attribute
 			    *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -443,7 +443,7 @@ static ssize_t show_in0_max(struct devic
 	return sprintf(buf, "%ld\n", in0_from_reg(data->in_high[nr]));
 }

-static ssize_t show_in0_min(struct device *dev, struct device_attribute
+static ssize_t in0_min_show(struct device *dev, struct device_attribute
 			    *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -453,8 +453,9 @@ static ssize_t show_in0_min(struct devic
 	return sprintf(buf, "%ld\n", in0_from_reg(data->in_low[nr]));
 }

-static ssize_t set_in0_max(struct device *dev, struct device_attribute
-			   *devattr, const char *buf, size_t count)
+static ssize_t in0_max_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -474,8 +475,9 @@ static ssize_t set_in0_max(struct device
 	return count;
 }

-static ssize_t set_in0_min(struct device *dev, struct device_attribute
-			   *devattr, const char *buf, size_t count)
+static ssize_t in0_min_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -495,7 +497,7 @@ static ssize_t set_in0_min(struct device
 	return count;
 }

-static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
+static ssize_t in_show(struct device *dev, struct device_attribute *devattr,
 		       char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -505,7 +507,7 @@ static ssize_t show_in(struct device *de
 	return sprintf(buf, "%ld\n", in_from_reg(data->in[nr]));
 }

-static ssize_t show_in_max(struct device *dev, struct device_attribute
+static ssize_t in_max_show(struct device *dev, struct device_attribute
 			   *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -515,7 +517,7 @@ static ssize_t show_in_max(struct device
 	return sprintf(buf, "%ld\n", in_from_reg(data->in_high[nr]));
 }

-static ssize_t show_in_min(struct device *dev, struct device_attribute
+static ssize_t in_min_show(struct device *dev, struct device_attribute
 			   *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -525,8 +527,9 @@ static ssize_t show_in_min(struct device
 	return sprintf(buf, "%ld\n", in_from_reg(data->in_low[nr]));
 }

-static ssize_t set_in_max(struct device *dev, struct device_attribute
-			  *devattr, const char *buf, size_t count)
+static ssize_t in_max_store(struct device *dev,
+			    struct device_attribute *devattr, const char *buf,
+			    size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -546,8 +549,9 @@ static ssize_t set_in_max(struct device
 	return count;
 }

-static ssize_t set_in_min(struct device *dev, struct device_attribute
-			  *devattr, const char *buf, size_t count)
+static ssize_t in_min_store(struct device *dev,
+			    struct device_attribute *devattr, const char *buf,
+			    size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -567,7 +571,7 @@ static ssize_t set_in_min(struct device
 	return count;
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
+static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -577,7 +581,7 @@ static ssize_t show_fan(struct device *d
 	return sprintf(buf, "%ld\n", fan_from_reg(data->fan[nr]));
 }

-static ssize_t show_fan_min(struct device *dev, struct device_attribute
+static ssize_t fan_min_show(struct device *dev, struct device_attribute
 			    *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -587,7 +591,7 @@ static ssize_t show_fan_min(struct devic
 	return sprintf(buf, "%ld\n", fan_from_reg(data->fan_low[nr]));
 }

-static ssize_t show_fan_target(struct device *dev, struct device_attribute
+static ssize_t fan_target_show(struct device *dev, struct device_attribute
 			       *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -597,8 +601,9 @@ static ssize_t show_fan_target(struct de
 	return sprintf(buf, "%ld\n", fan_from_reg(data->fan_target[nr]));
 }

-static ssize_t set_fan_min(struct device *dev, struct device_attribute
-			   *devattr, const char *buf, size_t count)
+static ssize_t fan_min_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -618,8 +623,9 @@ static ssize_t set_fan_min(struct device
 	return count;
 }

-static ssize_t set_fan_target(struct device *dev, struct device_attribute
-			      *devattr, const char *buf, size_t count)
+static ssize_t fan_target_store(struct device *dev,
+				struct device_attribute *devattr,
+				const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -650,7 +656,7 @@ static ssize_t show_pwm(struct device *d
 	return sprintf(buf, "%d\n", (int)data->pwm[nr]);
 }

-static ssize_t show_pwm_enable(struct device *dev, struct device_attribute
+static ssize_t pwm_enable_show(struct device *dev, struct device_attribute
 			       *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -672,7 +678,7 @@ static ssize_t show_pwm_enable(struct de
 	return sprintf(buf, "%d\n", mode);
 }

-static ssize_t show_pwm_freq(struct device *dev, struct device_attribute
+static ssize_t pwm_freq_show(struct device *dev, struct device_attribute
 			     *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -682,7 +688,7 @@ static ssize_t show_pwm_freq(struct devi
 	return sprintf(buf, "%lu\n", pwm_freq_from_reg(data->pwm_freq[nr]));
 }

-static ssize_t show_pwm_mode(struct device *dev, struct device_attribute
+static ssize_t pwm_mode_show(struct device *dev, struct device_attribute
 			     *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -718,8 +724,9 @@ static ssize_t set_pwm(struct device *de

 static struct attribute *f71805f_attr_pwm[];

-static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
-			      *devattr, const char *buf, size_t count)
+static ssize_t pwm_enable_store(struct device *dev,
+				struct device_attribute *devattr,
+				const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -768,8 +775,9 @@ static ssize_t set_pwm_enable(struct dev
 	return count;
 }

-static ssize_t set_pwm_freq(struct device *dev, struct device_attribute
-			    *devattr, const char *buf, size_t count)
+static ssize_t pwm_freq_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -789,7 +797,7 @@ static ssize_t set_pwm_freq(struct devic
 	return count;
 }

-static ssize_t show_pwm_auto_point_temp(struct device *dev,
+static ssize_t pwm_auto_point_temp_show(struct device *dev,
 					struct device_attribute *devattr,
 					char *buf)
 {
@@ -802,9 +810,9 @@ static ssize_t show_pwm_auto_point_temp(
 		       temp_from_reg(data->auto_points[pwmnr].temp[apnr]));
 }

-static ssize_t set_pwm_auto_point_temp(struct device *dev,
-				       struct device_attribute *devattr,
-				       const char *buf, size_t count)
+static ssize_t pwm_auto_point_temp_store(struct device *dev,
+					 struct device_attribute *devattr,
+					 const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
@@ -826,7 +834,7 @@ static ssize_t set_pwm_auto_point_temp(s
 	return count;
 }

-static ssize_t show_pwm_auto_point_fan(struct device *dev,
+static ssize_t pwm_auto_point_fan_show(struct device *dev,
 				       struct device_attribute *devattr,
 				       char *buf)
 {
@@ -839,9 +847,9 @@ static ssize_t show_pwm_auto_point_fan(s
 		       fan_from_reg(data->auto_points[pwmnr].fan[apnr]));
 }

-static ssize_t set_pwm_auto_point_fan(struct device *dev,
-				      struct device_attribute *devattr,
-				      const char *buf, size_t count)
+static ssize_t pwm_auto_point_fan_store(struct device *dev,
+					struct device_attribute *devattr,
+					const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
@@ -863,7 +871,7 @@ static ssize_t set_pwm_auto_point_fan(st
 	return count;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -873,7 +881,7 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%ld\n", temp_from_reg(data->temp[nr]));
 }

-static ssize_t show_temp_max(struct device *dev, struct device_attribute
+static ssize_t temp_max_show(struct device *dev, struct device_attribute
 			     *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -883,7 +891,7 @@ static ssize_t show_temp_max(struct devi
 	return sprintf(buf, "%ld\n", temp_from_reg(data->temp_high[nr]));
 }

-static ssize_t show_temp_hyst(struct device *dev, struct device_attribute
+static ssize_t temp_hyst_show(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -893,7 +901,7 @@ static ssize_t show_temp_hyst(struct dev
 	return sprintf(buf, "%ld\n", temp_from_reg(data->temp_hyst[nr]));
 }

-static ssize_t show_temp_type(struct device *dev, struct device_attribute
+static ssize_t temp_type_show(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -904,8 +912,9 @@ static ssize_t show_temp_type(struct dev
 	return sprintf(buf, "%u\n", (data->temp_mode & (1 << nr)) ? 3 : 4);
 }

-static ssize_t set_temp_max(struct device *dev, struct device_attribute
-			    *devattr, const char *buf, size_t count)
+static ssize_t temp_max_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -925,8 +934,9 @@ static ssize_t set_temp_max(struct devic
 	return count;
 }

-static ssize_t set_temp_hyst(struct device *dev, struct device_attribute
-			     *devattr, const char *buf, size_t count)
+static ssize_t temp_hyst_store(struct device *dev,
+			       struct device_attribute *devattr,
+			       const char *buf, size_t count)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -970,7 +980,7 @@ static ssize_t show_alarms_temp(struct d
 	return sprintf(buf, "%lu\n", (data->alarms >> 11) & 0x07);
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute
+static ssize_t alarm_show(struct device *dev, struct device_attribute
 			  *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);
@@ -988,194 +998,127 @@ static ssize_t show_name(struct device *
 	return sprintf(buf, "%s\n", data->name);
 }

-static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, show_in0, NULL, 0);
-static SENSOR_DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
-			  show_in0_max, set_in0_max, 0);
-static SENSOR_DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
-			  show_in0_min, set_in0_min, 0);
-static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 1);
-static SENSOR_DEVICE_ATTR(in1_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 1);
-static SENSOR_DEVICE_ATTR(in1_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 1);
-static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 2);
-static SENSOR_DEVICE_ATTR(in2_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 2);
-static SENSOR_DEVICE_ATTR(in2_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 2);
-static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 3);
-static SENSOR_DEVICE_ATTR(in3_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 3);
-static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 3);
-static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in, NULL, 4);
-static SENSOR_DEVICE_ATTR(in4_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 4);
-static SENSOR_DEVICE_ATTR(in4_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 4);
-static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in, NULL, 5);
-static SENSOR_DEVICE_ATTR(in5_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 5);
-static SENSOR_DEVICE_ATTR(in5_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 5);
-static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in, NULL, 6);
-static SENSOR_DEVICE_ATTR(in6_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 6);
-static SENSOR_DEVICE_ATTR(in6_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 6);
-static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_in, NULL, 7);
-static SENSOR_DEVICE_ATTR(in7_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 7);
-static SENSOR_DEVICE_ATTR(in7_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 7);
-static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, show_in, NULL, 8);
-static SENSOR_DEVICE_ATTR(in8_max, S_IRUGO | S_IWUSR,
-			  show_in_max, set_in_max, 8);
-static SENSOR_DEVICE_ATTR(in8_min, S_IRUGO | S_IWUSR,
-			  show_in_min, set_in_min, 8);
-static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, show_in0, NULL, 9);
-static SENSOR_DEVICE_ATTR(in9_max, S_IRUGO | S_IWUSR,
-			  show_in0_max, set_in0_max, 9);
-static SENSOR_DEVICE_ATTR(in9_min, S_IRUGO | S_IWUSR,
-			  show_in0_min, set_in0_min, 9);
-static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, show_in0, NULL, 10);
-static SENSOR_DEVICE_ATTR(in10_max, S_IRUGO | S_IWUSR,
-			  show_in0_max, set_in0_max, 10);
-static SENSOR_DEVICE_ATTR(in10_min, S_IRUGO | S_IWUSR,
-			  show_in0_min, set_in0_min, 10);
-
-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan1_min, S_IRUGO | S_IWUSR,
-			  show_fan_min, set_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR,
-			  show_fan_target, set_fan_target, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IRUGO | S_IWUSR,
-			  show_fan_min, set_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan2_target, S_IRUGO | S_IWUSR,
-			  show_fan_target, set_fan_target, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan3_min, S_IRUGO | S_IWUSR,
-			  show_fan_min, set_fan_min, 2);
-static SENSOR_DEVICE_ATTR(fan3_target, S_IRUGO | S_IWUSR,
-			  show_fan_target, set_fan_target, 2);
-
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR,
-		    show_temp_hyst, set_temp_hyst, 0);
-static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, 1);
-static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO | S_IWUSR,
-		    show_temp_hyst, set_temp_hyst, 1);
-static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR,
-		    show_temp_max, set_temp_max, 2);
-static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IRUGO | S_IWUSR,
-		    show_temp_hyst, set_temp_hyst, 2);
-static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2);
+static SENSOR_DEVICE_ATTR_RO(in0_input, in0, 0);
+static SENSOR_DEVICE_ATTR_RW(in0_max, in0_max, 0);
+static SENSOR_DEVICE_ATTR_RW(in0_min, in0_min, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_input, in, 1);
+static SENSOR_DEVICE_ATTR_RW(in1_max, in_max, 1);
+static SENSOR_DEVICE_ATTR_RW(in1_min, in_min, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, in, 2);
+static SENSOR_DEVICE_ATTR_RW(in2_max, in_max, 2);
+static SENSOR_DEVICE_ATTR_RW(in2_min, in_min, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, in, 3);
+static SENSOR_DEVICE_ATTR_RW(in3_max, in_max, 3);
+static SENSOR_DEVICE_ATTR_RW(in3_min, in_min, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, in, 4);
+static SENSOR_DEVICE_ATTR_RW(in4_max, in_max, 4);
+static SENSOR_DEVICE_ATTR_RW(in4_min, in_min, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_input, in, 5);
+static SENSOR_DEVICE_ATTR_RW(in5_max, in_max, 5);
+static SENSOR_DEVICE_ATTR_RW(in5_min, in_min, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_input, in, 6);
+static SENSOR_DEVICE_ATTR_RW(in6_max, in_max, 6);
+static SENSOR_DEVICE_ATTR_RW(in6_min, in_min, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_input, in, 7);
+static SENSOR_DEVICE_ATTR_RW(in7_max, in_max, 7);
+static SENSOR_DEVICE_ATTR_RW(in7_min, in_min, 7);
+static SENSOR_DEVICE_ATTR_RO(in8_input, in, 8);
+static SENSOR_DEVICE_ATTR_RW(in8_max, in_max, 8);
+static SENSOR_DEVICE_ATTR_RW(in8_min, in_min, 8);
+static SENSOR_DEVICE_ATTR_RO(in9_input, in0, 9);
+static SENSOR_DEVICE_ATTR_RW(in9_max, in0_max, 9);
+static SENSOR_DEVICE_ATTR_RW(in9_min, in0_min, 9);
+static SENSOR_DEVICE_ATTR_RO(in10_input, in0, 10);
+static SENSOR_DEVICE_ATTR_RW(in10_max, in0_max, 10);
+static SENSOR_DEVICE_ATTR_RW(in10_min, in0_min, 10);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, 0);
+static SENSOR_DEVICE_ATTR_RW(fan1_min, fan_min, 0);
+static SENSOR_DEVICE_ATTR_RW(fan1_target, fan_target, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan, 1);
+static SENSOR_DEVICE_ATTR_RW(fan2_min, fan_min, 1);
+static SENSOR_DEVICE_ATTR_RW(fan2_target, fan_target, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan, 2);
+static SENSOR_DEVICE_ATTR_RW(fan3_min, fan_min, 2);
+static SENSOR_DEVICE_ATTR_RW(fan3_target, fan_target, 2);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp_hyst, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_type, temp_type, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
+static SENSOR_DEVICE_ATTR_RW(temp2_max_hyst, temp_hyst, 1);
+static SENSOR_DEVICE_ATTR_RO(temp2_type, temp_type, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 2);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, temp_max, 2);
+static SENSOR_DEVICE_ATTR_RW(temp3_max_hyst, temp_hyst, 2);
+static SENSOR_DEVICE_ATTR_RO(temp3_type, temp_type, 2);

 /*
  * pwm (value) files are created read-only, write permission is
  * then added or removed dynamically as needed
  */
 static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO, show_pwm, set_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
-			  show_pwm_enable, set_pwm_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm1_freq, S_IRUGO | S_IWUSR,
-			  show_pwm_freq, set_pwm_freq, 0);
-static SENSOR_DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm1_freq, pwm_freq, 0);
+static SENSOR_DEVICE_ATTR_RO(pwm1_mode, pwm_mode, 0);
 static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO, show_pwm, set_pwm, 1);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR,
-			  show_pwm_enable, set_pwm_enable, 1);
-static SENSOR_DEVICE_ATTR(pwm2_freq, S_IRUGO | S_IWUSR,
-			  show_pwm_freq, set_pwm_freq, 1);
-static SENSOR_DEVICE_ATTR(pwm2_mode, S_IRUGO, show_pwm_mode, NULL, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_enable, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm2_freq, pwm_freq, 1);
+static SENSOR_DEVICE_ATTR_RO(pwm2_mode, pwm_mode, 1);
 static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO, show_pwm, set_pwm, 2);
-static SENSOR_DEVICE_ATTR(pwm3_enable, S_IRUGO | S_IWUSR,
-			  show_pwm_enable, set_pwm_enable, 2);
-static SENSOR_DEVICE_ATTR(pwm3_freq, S_IRUGO | S_IWUSR,
-			  show_pwm_freq, set_pwm_freq, 2);
-static SENSOR_DEVICE_ATTR(pwm3_mode, S_IRUGO, show_pwm_mode, NULL, 2);
-
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
-			    0, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point1_fan, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
-			    0, 0);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
-			    0, 1);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point2_fan, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
-			    0, 1);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
-			    0, 2);
-static SENSOR_DEVICE_ATTR_2(pwm1_auto_point3_fan, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
-			    0, 2);
-
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
-			    1, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point1_fan, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
-			    1, 0);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
-			    1, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point2_fan, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
-			    1, 1);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
-			    1, 2);
-static SENSOR_DEVICE_ATTR_2(pwm2_auto_point3_fan, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
-			    1, 2);
-
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_temp, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
-			    2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point1_fan, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
-			    2, 0);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_temp, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
-			    2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point2_fan, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
-			    2, 1);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point3_temp, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_temp, set_pwm_auto_point_temp,
-			    2, 2);
-static SENSOR_DEVICE_ATTR_2(pwm3_auto_point3_fan, S_IRUGO | S_IWUSR,
-			    show_pwm_auto_point_fan, set_pwm_auto_point_fan,
-			    2, 2);
-
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(in9_alarm, S_IRUGO, show_alarm, NULL, 9);
-static SENSOR_DEVICE_ATTR(in10_alarm, S_IRUGO, show_alarm, NULL, 10);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 12);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 16);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 17);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 18);
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwm_enable, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm3_freq, pwm_freq, 2);
+static SENSOR_DEVICE_ATTR_RO(pwm3_mode, pwm_mode, 2);
+
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_temp, pwm_auto_point_temp, 0,
+			       0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point1_fan, pwm_auto_point_fan, 0, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_temp, pwm_auto_point_temp, 0,
+			       1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point2_fan, pwm_auto_point_fan, 0, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_temp, pwm_auto_point_temp, 0,
+			       2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm1_auto_point3_fan, pwm_auto_point_fan, 0, 2);
+
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_temp, pwm_auto_point_temp, 1,
+			       0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point1_fan, pwm_auto_point_fan, 1, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_temp, pwm_auto_point_temp, 1,
+			       1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point2_fan, pwm_auto_point_fan, 1, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point3_temp, pwm_auto_point_temp, 1,
+			       2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm2_auto_point3_fan, pwm_auto_point_fan, 1, 2);
+
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_temp, pwm_auto_point_temp, 2,
+			       0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point1_fan, pwm_auto_point_fan, 2, 0);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_temp, pwm_auto_point_temp, 2,
+			       1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point2_fan, pwm_auto_point_fan, 2, 1);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_temp, pwm_auto_point_temp, 2,
+			       2);
+static SENSOR_DEVICE_ATTR_2_RW(pwm3_auto_point3_fan, pwm_auto_point_fan, 2, 2);
+
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(in5_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(in6_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(in7_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(in8_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(in9_alarm, alarm, 9);
+static SENSOR_DEVICE_ATTR_RO(in10_alarm, alarm, 10);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 12);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 13);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 16);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 17);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, 18);
 static DEVICE_ATTR(alarms_in, S_IRUGO, show_alarms_in, NULL);
 static DEVICE_ATTR(alarms_fan, S_IRUGO, show_alarms_fan, NULL);
 static DEVICE_ATTR(alarms_temp, S_IRUGO, show_alarms_temp, NULL);
diff -u -p a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -530,24 +530,24 @@ static ssize_t show_alarms(struct device

 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 7);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 13);

 /* 1 PWM */
 static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr,
diff -u -p a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -142,7 +142,7 @@ static struct lm92_data *lm92_update_dev
 	return data;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -151,8 +151,9 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
 }

-static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
-			   const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm92_data *data = dev_get_drvdata(dev);
@@ -172,7 +173,7 @@ static ssize_t set_temp(struct device *d
 	return count;
 }

-static ssize_t show_temp_hyst(struct device *dev,
+static ssize_t temp_hyst_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -189,9 +190,9 @@ static ssize_t show_temp_min_hyst(struct
 		       + TEMP_FROM_REG(data->temp[t_hyst]));
 }

-static ssize_t set_temp_hyst(struct device *dev,
-			     struct device_attribute *devattr,
-			     const char *buf, size_t count)
+static ssize_t temp_hyst_store(struct device *dev,
+			       struct device_attribute *devattr,
+			       const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm92_data *data = dev_get_drvdata(dev);
@@ -220,7 +221,7 @@ static ssize_t show_alarms(struct device
 	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->temp[t_input]));
 }

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
@@ -228,21 +229,17 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%d\n", (data->temp[t_input] >> bitnr) & 1);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, t_input);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IWUSR | S_IRUGO, show_temp, set_temp,
-			  t_crit);
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp_hyst,
-			  set_temp_hyst, t_crit);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp,
-			  t_min);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, t_input);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp, t_crit);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit_hyst, temp_hyst, t_crit);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp, t_min);
 static DEVICE_ATTR(temp1_min_hyst, S_IRUGO, show_temp_min_hyst, NULL);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp,
-			  t_max);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_temp_hyst, NULL, t_max);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, t_max);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_hyst, temp_hyst, t_max);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 1);

 /*
  * Detection and registration
diff -u -p a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -62,8 +62,8 @@ struct lm73_data {

 /*-----------------------------------------------------------------------*/

-static ssize_t set_temp(struct device *dev, struct device_attribute *da,
-			const char *buf, size_t count)
+static ssize_t temp_store(struct device *dev, struct device_attribute *da,
+			  const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
 	struct lm73_data *data = dev_get_drvdata(dev);
@@ -81,7 +81,7 @@ static ssize_t set_temp(struct device *d
 	return (err < 0) ? err : count;
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *da,
+static ssize_t temp_show(struct device *dev, struct device_attribute *da,
 			 char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -98,8 +98,8 @@ static ssize_t show_temp(struct device *
 	return scnprintf(buf, PAGE_SIZE, "%d\n", temp);
 }

-static ssize_t set_convrate(struct device *dev, struct device_attribute *da,
-			    const char *buf, size_t count)
+static ssize_t convrate_store(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
 {
 	struct lm73_data *data = dev_get_drvdata(dev);
 	unsigned long convrate;
@@ -133,7 +133,7 @@ static ssize_t set_convrate(struct devic
 	return count;
 }

-static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
+static ssize_t convrate_show(struct device *dev, struct device_attribute *da,
 			     char *buf)
 {
 	struct lm73_data *data = dev_get_drvdata(dev);
@@ -143,7 +143,7 @@ static ssize_t show_convrate(struct devi
 	return scnprintf(buf, PAGE_SIZE, "%hu\n", lm73_convrates[res]);
 }

-static ssize_t show_maxmin_alarm(struct device *dev,
+static ssize_t maxmin_alarm_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
@@ -168,18 +168,14 @@ abort:

 /* sysfs attributes for hwmon */

-static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
-			show_temp, set_temp, LM73_REG_MAX);
-static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
-			show_temp, set_temp, LM73_REG_MIN);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
-			show_temp, NULL, LM73_REG_INPUT);
-static SENSOR_DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO,
-			show_convrate, set_convrate, 0);
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO,
-			show_maxmin_alarm, NULL, LM73_CTRL_HI_SHIFT);
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO,
-			show_maxmin_alarm, NULL, LM73_CTRL_LO_SHIFT);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, LM73_REG_MAX);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp, LM73_REG_MIN);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, LM73_REG_INPUT);
+static SENSOR_DEVICE_ATTR_RW(update_interval, convrate, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, maxmin_alarm,
+			     LM73_CTRL_HI_SHIFT);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, maxmin_alarm,
+			     LM73_CTRL_LO_SHIFT);

 static struct attribute *lm73_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -43,7 +43,7 @@ struct thermal_data {
 	const struct attribute_group *groups[4];
 };

-static ssize_t show_temp(struct device *dev,
+static ssize_t temp_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
@@ -57,7 +57,7 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d000\n", val);
 }

-static ssize_t show_bit(struct device *dev,
+static ssize_t bit_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute_2 *sda = to_sensor_dev_attr_2(attr);
@@ -71,7 +71,7 @@ static ssize_t show_bit(struct device *d
 	return sprintf(buf, "%d\n", !!(val & sda->index));
 }

-static ssize_t store_temp(struct device *dev,
+static ssize_t temp_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
@@ -88,7 +88,7 @@ static ssize_t store_temp(struct device
 	return count;
 }

-static ssize_t store_bit(struct device *dev,
+static ssize_t bit_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct sensor_device_attribute_2 *sda = to_sensor_dev_attr_2(attr);
@@ -128,19 +128,19 @@ static ssize_t show_hyst_common(struct d
 	return sprintf(buf, "%d000\n", is_min ? limit + hyst : limit - hyst);
 }

-static ssize_t show_hyst(struct device *dev,
+static ssize_t hyst_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
 	return show_hyst_common(dev, attr, buf, false);
 }

-static ssize_t show_min_hyst(struct device *dev,
+static ssize_t min_hyst_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
 	return show_hyst_common(dev, attr, buf, true);
 }

-static ssize_t store_hyst(struct device *dev,
+static ssize_t hyst_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
@@ -173,80 +173,54 @@ fail:
  *	Sensors. We pass the actual i2c register to the methods.
  */

-static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x06);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x05);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x20);
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0x00);
-static SENSOR_DEVICE_ATTR_2(temp1_min_alarm, S_IRUGO,
-	show_bit, NULL, 0x36, 0x01);
-static SENSOR_DEVICE_ATTR_2(temp1_max_alarm, S_IRUGO,
-	show_bit, NULL, 0x35, 0x01);
-static SENSOR_DEVICE_ATTR_2(temp1_crit_alarm, S_IRUGO,
-	show_bit, NULL, 0x37, 0x01);
-static SENSOR_DEVICE_ATTR(temp1_min_hyst, S_IRUGO, show_min_hyst, NULL, 0x06);
-static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_hyst, NULL, 0x05);
-static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO | S_IWUSR,
-	show_hyst, store_hyst, 0x20);
-
-static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x08);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x07);
-static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x19);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 0x01);
-static SENSOR_DEVICE_ATTR_2(temp2_fault, S_IRUGO, show_bit, NULL, 0x1b, 0x02);
-static SENSOR_DEVICE_ATTR_2(temp2_min_alarm, S_IRUGO,
-	show_bit, NULL, 0x36, 0x02);
-static SENSOR_DEVICE_ATTR_2(temp2_max_alarm, S_IRUGO,
-	show_bit, NULL, 0x35, 0x02);
-static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO,
-	show_bit, NULL, 0x37, 0x02);
-static SENSOR_DEVICE_ATTR(temp2_min_hyst, S_IRUGO, show_min_hyst, NULL, 0x08);
-static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO, show_hyst, NULL, 0x07);
-static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IRUGO, show_hyst, NULL, 0x19);
-
-static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x16);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x15);
-static SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x1A);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 0x23);
-static SENSOR_DEVICE_ATTR_2(temp3_fault, S_IRUGO, show_bit, NULL, 0x1b, 0x04);
-static SENSOR_DEVICE_ATTR_2(temp3_min_alarm, S_IRUGO,
-	show_bit, NULL, 0x36, 0x04);
-static SENSOR_DEVICE_ATTR_2(temp3_max_alarm, S_IRUGO,
-	show_bit, NULL, 0x35, 0x04);
-static SENSOR_DEVICE_ATTR_2(temp3_crit_alarm, S_IRUGO,
-	show_bit, NULL, 0x37, 0x04);
-static SENSOR_DEVICE_ATTR(temp3_min_hyst, S_IRUGO, show_min_hyst, NULL, 0x16);
-static SENSOR_DEVICE_ATTR(temp3_max_hyst, S_IRUGO, show_hyst, NULL, 0x15);
-static SENSOR_DEVICE_ATTR(temp3_crit_hyst, S_IRUGO, show_hyst, NULL, 0x1A);
-
-static SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x2D);
-static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x2C);
-static SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO | S_IWUSR,
-	show_temp, store_temp, 0x30);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp, NULL, 0x2A);
-static SENSOR_DEVICE_ATTR_2(temp4_fault, S_IRUGO, show_bit, NULL, 0x1b, 0x08);
-static SENSOR_DEVICE_ATTR_2(temp4_min_alarm, S_IRUGO,
-	show_bit, NULL, 0x36, 0x08);
-static SENSOR_DEVICE_ATTR_2(temp4_max_alarm, S_IRUGO,
-	show_bit, NULL, 0x35, 0x08);
-static SENSOR_DEVICE_ATTR_2(temp4_crit_alarm, S_IRUGO,
-	show_bit, NULL, 0x37, 0x08);
-static SENSOR_DEVICE_ATTR(temp4_min_hyst, S_IRUGO, show_min_hyst, NULL, 0x2D);
-static SENSOR_DEVICE_ATTR(temp4_max_hyst, S_IRUGO, show_hyst, NULL, 0x2C);
-static SENSOR_DEVICE_ATTR(temp4_crit_hyst, S_IRUGO, show_hyst, NULL, 0x30);
+static SENSOR_DEVICE_ATTR_RW(temp1_min, temp, 0x06);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, 0x05);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp, 0x20);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0x00);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_min_alarm, bit, 0x36, 0x01);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_max_alarm, bit, 0x35, 0x01);
+static SENSOR_DEVICE_ATTR_2_RO(temp1_crit_alarm, bit, 0x37, 0x01);
+static SENSOR_DEVICE_ATTR_RO(temp1_min_hyst, min_hyst, 0x06);
+static SENSOR_DEVICE_ATTR_RO(temp1_max_hyst, hyst, 0x05);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit_hyst, hyst, 0x20);
+
+static SENSOR_DEVICE_ATTR_RW(temp2_min, temp, 0x08);
+static SENSOR_DEVICE_ATTR_RW(temp2_max, temp, 0x07);
+static SENSOR_DEVICE_ATTR_RW(temp2_crit, temp, 0x19);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, 0x01);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_fault, bit, 0x1b, 0x02);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_min_alarm, bit, 0x36, 0x02);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_max_alarm, bit, 0x35, 0x02);
+static SENSOR_DEVICE_ATTR_2_RO(temp2_crit_alarm, bit, 0x37, 0x02);
+static SENSOR_DEVICE_ATTR_RO(temp2_min_hyst, min_hyst, 0x08);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_hyst, hyst, 0x07);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_hyst, hyst, 0x19);
+
+static SENSOR_DEVICE_ATTR_RW(temp3_min, temp, 0x16);
+static SENSOR_DEVICE_ATTR_RW(temp3_max, temp, 0x15);
+static SENSOR_DEVICE_ATTR_RW(temp3_crit, temp, 0x1A);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp, 0x23);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_fault, bit, 0x1b, 0x04);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_min_alarm, bit, 0x36, 0x04);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_max_alarm, bit, 0x35, 0x04);
+static SENSOR_DEVICE_ATTR_2_RO(temp3_crit_alarm, bit, 0x37, 0x04);
+static SENSOR_DEVICE_ATTR_RO(temp3_min_hyst, min_hyst, 0x16);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_hyst, hyst, 0x15);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_hyst, hyst, 0x1A);
+
+static SENSOR_DEVICE_ATTR_RW(temp4_min, temp, 0x2D);
+static SENSOR_DEVICE_ATTR_RW(temp4_max, temp, 0x2C);
+static SENSOR_DEVICE_ATTR_RW(temp4_crit, temp, 0x30);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp, 0x2A);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_fault, bit, 0x1b, 0x08);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_min_alarm, bit, 0x36, 0x08);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_max_alarm, bit, 0x35, 0x08);
+static SENSOR_DEVICE_ATTR_2_RO(temp4_crit_alarm, bit, 0x37, 0x08);
+static SENSOR_DEVICE_ATTR_RO(temp4_min_hyst, min_hyst, 0x2D);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_hyst, hyst, 0x2C);
+static SENSOR_DEVICE_ATTR_RO(temp4_crit_hyst, hyst, 0x30);

-static SENSOR_DEVICE_ATTR_2(power_state, S_IRUGO | S_IWUSR,
-	show_bit, store_bit, 0x03, 0x40);
+static SENSOR_DEVICE_ATTR_2_RW(power_state, bit, 0x03, 0x40);

 static struct attribute *emc1402_attrs[] = {
 	&sensor_dev_attr_temp1_min.dev_attr.attr,
@@ -328,14 +302,14 @@ static const struct attribute_group emc1
  * array.
  */
 static struct sensor_device_attribute_2 emc1402_alarms[] = {
-	SENSOR_ATTR_2(temp1_min_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x20),
-	SENSOR_ATTR_2(temp1_max_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x40),
-	SENSOR_ATTR_2(temp1_crit_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x01),
-
-	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_bit, NULL, 0x02, 0x04),
-	SENSOR_ATTR_2(temp2_min_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x08),
-	SENSOR_ATTR_2(temp2_max_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x10),
-	SENSOR_ATTR_2(temp2_crit_alarm, S_IRUGO, show_bit, NULL, 0x02, 0x02),
+	SENSOR_ATTR_2(temp1_min_alarm, S_IRUGO, bit_show, NULL, 0x02, 0x20),
+	SENSOR_ATTR_2(temp1_max_alarm, S_IRUGO, bit_show, NULL, 0x02, 0x40),
+	SENSOR_ATTR_2(temp1_crit_alarm, S_IRUGO, bit_show, NULL, 0x02, 0x01),
+
+	SENSOR_ATTR_2(temp2_fault, S_IRUGO, bit_show, NULL, 0x02, 0x04),
+	SENSOR_ATTR_2(temp2_min_alarm, S_IRUGO, bit_show, NULL, 0x02, 0x08),
+	SENSOR_ATTR_2(temp2_max_alarm, S_IRUGO, bit_show, NULL, 0x02, 0x10),
+	SENSOR_ATTR_2(temp2_crit_alarm, S_IRUGO, bit_show, NULL, 0x02, 0x02),
 };

 static struct attribute *emc1402_alarm_attrs[] = {
diff -u -p a/drivers/hwmon/tc74.c b/drivers/hwmon/tc74.c
--- a/drivers/hwmon/tc74.c
+++ b/drivers/hwmon/tc74.c
@@ -86,7 +86,7 @@ ret_unlock:
 	return ret;
 }

-static ssize_t show_temp_input(struct device *dev,
+static ssize_t temp_input_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct tc74_data *data = dev_get_drvdata(dev);
@@ -98,7 +98,7 @@ static ssize_t show_temp_input(struct de

 	return sprintf(buf, "%d\n", data->temp_input * 1000);
 }
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);

 static struct attribute *tc74_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -589,23 +589,23 @@ static ssize_t show_alarms(struct device

 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);

-static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
+static ssize_t alarm_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	int bitnr = to_sensor_dev_attr(attr)->index;
 	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf, "%u\n", (data->alarms >> bitnr) & 1);
 }
-static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8);
-static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 11);
-static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 15);
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(in0_alarm, alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_alarm, alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_alarm, alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_alarm, alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_alarm, alarm, 8);
+static SENSOR_DEVICE_ATTR_RO(temp1_alarm, alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp2_alarm, alarm, 11);
+static SENSOR_DEVICE_ATTR_RO(temp3_alarm, alarm, 15);
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, alarm, 7);

 static ssize_t show_name(struct device *dev, struct device_attribute
 			 *devattr, char *buf)
diff -u -p a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -384,7 +384,7 @@ done:
 	return data;
 }

-static ssize_t show_fan_input(struct device *dev, struct device_attribute
+static ssize_t fan_input_show(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -393,7 +393,7 @@ static ssize_t show_fan_input(struct dev
 	return sprintf(buf, "%lu\n", fan_from_reg(data->fan[nr]));
 }

-static ssize_t show_fan_min(struct device *dev, struct device_attribute
+static ssize_t fan_min_show(struct device *dev, struct device_attribute
 			    *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -402,7 +402,7 @@ static ssize_t show_fan_min(struct devic
 	return sprintf(buf, "%lu\n", fan_from_reg(data->fan_min[nr]));
 }

-static ssize_t show_fan_alarm(struct device *dev, struct device_attribute
+static ssize_t fan_alarm_show(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -412,7 +412,7 @@ static ssize_t show_fan_alarm(struct dev
 				       & FAN_STATUS_LOSPD));
 }

-static ssize_t show_fan_fault(struct device *dev, struct device_attribute
+static ssize_t fan_fault_show(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -422,8 +422,9 @@ static ssize_t show_fan_fault(struct dev
 				       & FAN_STATUS_STALL));
 }

-static ssize_t set_fan_min(struct device *dev, struct device_attribute
-			   *devattr, const char *buf, size_t count)
+static ssize_t fan_min_store(struct device *dev,
+			     struct device_attribute *devattr,
+			     const char *buf, size_t count)
 {
 	struct pc87427_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr(devattr)->index;
@@ -449,49 +450,41 @@ static ssize_t set_fan_min(struct device
 	return count;
 }

-static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan_input, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan_input, NULL, 3);
-static SENSOR_DEVICE_ATTR(fan5_input, S_IRUGO, show_fan_input, NULL, 4);
-static SENSOR_DEVICE_ATTR(fan6_input, S_IRUGO, show_fan_input, NULL, 5);
-static SENSOR_DEVICE_ATTR(fan7_input, S_IRUGO, show_fan_input, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan8_input, S_IRUGO, show_fan_input, NULL, 7);
-
-static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, set_fan_min, 0);
-static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, set_fan_min, 1);
-static SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, set_fan_min, 2);
-static SENSOR_DEVICE_ATTR(fan4_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, set_fan_min, 3);
-static SENSOR_DEVICE_ATTR(fan5_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, set_fan_min, 4);
-static SENSOR_DEVICE_ATTR(fan6_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, set_fan_min, 5);
-static SENSOR_DEVICE_ATTR(fan7_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, set_fan_min, 6);
-static SENSOR_DEVICE_ATTR(fan8_min, S_IWUSR | S_IRUGO,
-			  show_fan_min, set_fan_min, 7);
-
-static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_fan_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_fan_alarm, NULL, 5);
-static SENSOR_DEVICE_ATTR(fan7_alarm, S_IRUGO, show_fan_alarm, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan8_alarm, S_IRUGO, show_fan_alarm, NULL, 7);
-
-static SENSOR_DEVICE_ATTR(fan1_fault, S_IRUGO, show_fan_fault, NULL, 0);
-static SENSOR_DEVICE_ATTR(fan2_fault, S_IRUGO, show_fan_fault, NULL, 1);
-static SENSOR_DEVICE_ATTR(fan3_fault, S_IRUGO, show_fan_fault, NULL, 2);
-static SENSOR_DEVICE_ATTR(fan4_fault, S_IRUGO, show_fan_fault, NULL, 3);
-static SENSOR_DEVICE_ATTR(fan5_fault, S_IRUGO, show_fan_fault, NULL, 4);
-static SENSOR_DEVICE_ATTR(fan6_fault, S_IRUGO, show_fan_fault, NULL, 5);
-static SENSOR_DEVICE_ATTR(fan7_fault, S_IRUGO, show_fan_fault, NULL, 6);
-static SENSOR_DEVICE_ATTR(fan8_fault, S_IRUGO, show_fan_fault, NULL, 7);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan_input, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan_input, 3);
+static SENSOR_DEVICE_ATTR_RO(fan5_input, fan_input, 4);
+static SENSOR_DEVICE_ATTR_RO(fan6_input, fan_input, 5);
+static SENSOR_DEVICE_ATTR_RO(fan7_input, fan_input, 6);
+static SENSOR_DEVICE_ATTR_RO(fan8_input, fan_input, 7);
+
+static SENSOR_DEVICE_ATTR_RW(fan1_min, fan_min, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_min, fan_min, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_min, fan_min, 2);
+static SENSOR_DEVICE_ATTR_RW(fan4_min, fan_min, 3);
+static SENSOR_DEVICE_ATTR_RW(fan5_min, fan_min, 4);
+static SENSOR_DEVICE_ATTR_RW(fan6_min, fan_min, 5);
+static SENSOR_DEVICE_ATTR_RW(fan7_min, fan_min, 6);
+static SENSOR_DEVICE_ATTR_RW(fan8_min, fan_min, 7);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_alarm, fan_alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_alarm, fan_alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_alarm, fan_alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_alarm, fan_alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(fan5_alarm, fan_alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(fan6_alarm, fan_alarm, 5);
+static SENSOR_DEVICE_ATTR_RO(fan7_alarm, fan_alarm, 6);
+static SENSOR_DEVICE_ATTR_RO(fan8_alarm, fan_alarm, 7);
+
+static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan_fault, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_fault, fan_fault, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_fault, fan_fault, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_fault, fan_fault, 3);
+static SENSOR_DEVICE_ATTR_RO(fan5_fault, fan_fault, 4);
+static SENSOR_DEVICE_ATTR_RO(fan6_fault, fan_fault, 5);
+static SENSOR_DEVICE_ATTR_RO(fan7_fault, fan_fault, 6);
+static SENSOR_DEVICE_ATTR_RO(fan8_fault, fan_fault, 7);

 static struct attribute *pc87427_attributes_fan[8][5] = {
 	{
@@ -568,7 +561,7 @@ static void update_pwm_enable(struct pc8
 	outb(data->pwm_enable[nr], iobase + PC87427_REG_PWM_ENABLE);
 }

-static ssize_t show_pwm_enable(struct device *dev, struct device_attribute
+static ssize_t pwm_enable_show(struct device *dev, struct device_attribute
 			       *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -581,8 +574,9 @@ static ssize_t show_pwm_enable(struct de
 	return sprintf(buf, "%d\n", pwm_enable);
 }

-static ssize_t set_pwm_enable(struct device *dev, struct device_attribute
-			      *devattr, const char *buf, size_t count)
+static ssize_t pwm_enable_store(struct device *dev,
+				struct device_attribute *devattr,
+				const char *buf, size_t count)
 {
 	struct pc87427_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr(devattr)->index;
@@ -602,7 +596,7 @@ static ssize_t set_pwm_enable(struct dev
 	return count;
 }

-static ssize_t show_pwm(struct device *dev, struct device_attribute
+static ssize_t pwm_show(struct device *dev, struct device_attribute
 			*devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -611,8 +605,8 @@ static ssize_t show_pwm(struct device *d
 	return sprintf(buf, "%d\n", (int)data->pwm[nr]);
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute
-		       *devattr, const char *buf, size_t count)
+static ssize_t pwm_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
 {
 	struct pc87427_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr(devattr)->index;
@@ -657,19 +651,15 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }

-static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
-			  show_pwm_enable, set_pwm_enable, 0);
-static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO,
-			  show_pwm_enable, set_pwm_enable, 1);
-static SENSOR_DEVICE_ATTR(pwm3_enable, S_IWUSR | S_IRUGO,
-			  show_pwm_enable, set_pwm_enable, 2);
-static SENSOR_DEVICE_ATTR(pwm4_enable, S_IWUSR | S_IRUGO,
-			  show_pwm_enable, set_pwm_enable, 3);
-
-static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 0);
-static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 1);
-static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2);
-static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 3);
+static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_enable, pwm_enable, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_enable, pwm_enable, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_enable, pwm_enable, 3);
+
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3, pwm, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4, pwm, 3);

 static struct attribute *pc87427_attributes_pwm[4][3] = {
 	{
@@ -698,7 +688,7 @@ static const struct attribute_group pc87
 	{ .attrs = pc87427_attributes_pwm[3] },
 };

-static ssize_t show_temp_input(struct device *dev, struct device_attribute
+static ssize_t temp_input_show(struct device *dev, struct device_attribute
 			       *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -707,7 +697,7 @@ static ssize_t show_temp_input(struct de
 	return sprintf(buf, "%ld\n", temp_from_reg(data->temp[nr]));
 }

-static ssize_t show_temp_min(struct device *dev, struct device_attribute
+static ssize_t temp_min_show(struct device *dev, struct device_attribute
 			     *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -716,7 +706,7 @@ static ssize_t show_temp_min(struct devi
 	return sprintf(buf, "%ld\n", temp_from_reg8(data->temp_min[nr]));
 }

-static ssize_t show_temp_max(struct device *dev, struct device_attribute
+static ssize_t temp_max_show(struct device *dev, struct device_attribute
 			     *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -725,7 +715,7 @@ static ssize_t show_temp_max(struct devi
 	return sprintf(buf, "%ld\n", temp_from_reg8(data->temp_max[nr]));
 }

-static ssize_t show_temp_crit(struct device *dev, struct device_attribute
+static ssize_t temp_crit_show(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -734,7 +724,7 @@ static ssize_t show_temp_crit(struct dev
 	return sprintf(buf, "%ld\n", temp_from_reg8(data->temp_crit[nr]));
 }

-static ssize_t show_temp_type(struct device *dev, struct device_attribute
+static ssize_t temp_type_show(struct device *dev, struct device_attribute
 			      *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -743,7 +733,7 @@ static ssize_t show_temp_type(struct dev
 	return sprintf(buf, "%u\n", temp_type_from_reg(data->temp_type[nr]));
 }

-static ssize_t show_temp_min_alarm(struct device *dev, struct device_attribute
+static ssize_t temp_min_alarm_show(struct device *dev, struct device_attribute
 				   *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -753,7 +743,7 @@ static ssize_t show_temp_min_alarm(struc
 				       & TEMP_STATUS_LOWFLG));
 }

-static ssize_t show_temp_max_alarm(struct device *dev, struct device_attribute
+static ssize_t temp_max_alarm_show(struct device *dev, struct device_attribute
 				   *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -763,7 +753,7 @@ static ssize_t show_temp_max_alarm(struc
 				       & TEMP_STATUS_HIGHFLG));
 }

-static ssize_t show_temp_crit_alarm(struct device *dev, struct device_attribute
+static ssize_t temp_crit_alarm_show(struct device *dev, struct device_attribute
 				   *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -773,7 +763,7 @@ static ssize_t show_temp_crit_alarm(stru
 				       & TEMP_STATUS_CRITFLG));
 }

-static ssize_t show_temp_fault(struct device *dev, struct device_attribute
+static ssize_t temp_fault_show(struct device *dev, struct device_attribute
 			       *devattr, char *buf)
 {
 	struct pc87427_data *data = pc87427_update_device(dev);
@@ -783,86 +773,68 @@ static ssize_t show_temp_fault(struct de
 				       & TEMP_STATUS_SENSERR));
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_input, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp_input, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp_input, NULL, 5);
-
-static SENSOR_DEVICE_ATTR(temp1_min, S_IRUGO, show_temp_min, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_min, S_IRUGO, show_temp_min, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_min, S_IRUGO, show_temp_min, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_min, S_IRUGO, show_temp_min, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_min, S_IRUGO, show_temp_min, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_min, S_IRUGO, show_temp_min, NULL, 5);
-
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_temp_max, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_max, S_IRUGO, show_temp_max, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_max, S_IRUGO, show_temp_max, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_max, S_IRUGO, show_temp_max, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_max, S_IRUGO, show_temp_max, NULL, 5);
-
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp_crit, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_crit, S_IRUGO, show_temp_crit, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_crit, S_IRUGO, show_temp_crit, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_crit, S_IRUGO, show_temp_crit, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_crit, S_IRUGO, show_temp_crit, NULL, 5);
-
-static SENSOR_DEVICE_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_type, S_IRUGO, show_temp_type, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_type, S_IRUGO, show_temp_type, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_type, S_IRUGO, show_temp_type, NULL, 5);
-
-static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO,
-			  show_temp_min_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO,
-			  show_temp_min_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_min_alarm, S_IRUGO,
-			  show_temp_min_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_min_alarm, S_IRUGO,
-			  show_temp_min_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_min_alarm, S_IRUGO,
-			  show_temp_min_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_min_alarm, S_IRUGO,
-			  show_temp_min_alarm, NULL, 5);
-
-static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO,
-			  show_temp_max_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO,
-			  show_temp_max_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_max_alarm, S_IRUGO,
-			  show_temp_max_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO,
-			  show_temp_max_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_max_alarm, S_IRUGO,
-			  show_temp_max_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_max_alarm, S_IRUGO,
-			  show_temp_max_alarm, NULL, 5);
-
-static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO,
-			  show_temp_crit_alarm, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO,
-			  show_temp_crit_alarm, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_crit_alarm, S_IRUGO,
-			  show_temp_crit_alarm, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_crit_alarm, S_IRUGO,
-			  show_temp_crit_alarm, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_crit_alarm, S_IRUGO,
-			  show_temp_crit_alarm, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_crit_alarm, S_IRUGO,
-			  show_temp_crit_alarm, NULL, 5);
-
-static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1);
-static SENSOR_DEVICE_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2);
-static SENSOR_DEVICE_ATTR(temp4_fault, S_IRUGO, show_temp_fault, NULL, 3);
-static SENSOR_DEVICE_ATTR(temp5_fault, S_IRUGO, show_temp_fault, NULL, 4);
-static SENSOR_DEVICE_ATTR(temp6_fault, S_IRUGO, show_temp_fault, NULL, 5);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_input, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_input, temp_input, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_input, temp_input, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_input, temp_input, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_input, temp_input, 5);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_min, temp_min, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_min, temp_min, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_min, temp_min, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_min, temp_min, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_min, temp_min, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_min, temp_min, 5);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_max, temp_max, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_max, temp_max, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_max, temp_max, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_max, temp_max, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_max, temp_max, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_max, temp_max, 5);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_crit, temp_crit, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit, temp_crit, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit, temp_crit, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_crit, temp_crit, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_crit, temp_crit, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_crit, temp_crit, 5);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_type, temp_type, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_type, temp_type, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_type, temp_type, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_type, temp_type, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_type, temp_type, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_type, temp_type, 5);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, temp_min_alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, temp_min_alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_min_alarm, temp_min_alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_min_alarm, temp_min_alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_min_alarm, temp_min_alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_min_alarm, temp_min_alarm, 5);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, temp_max_alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, temp_max_alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_max_alarm, temp_max_alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_max_alarm, temp_max_alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_max_alarm, temp_max_alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_max_alarm, temp_max_alarm, 5);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, temp_crit_alarm, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, temp_crit_alarm, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_crit_alarm, temp_crit_alarm, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_crit_alarm, temp_crit_alarm, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_crit_alarm, temp_crit_alarm, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_crit_alarm, temp_crit_alarm, 5);
+
+static SENSOR_DEVICE_ATTR_RO(temp1_fault, temp_fault, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp_fault, 1);
+static SENSOR_DEVICE_ATTR_RO(temp3_fault, temp_fault, 2);
+static SENSOR_DEVICE_ATTR_RO(temp4_fault, temp_fault, 3);
+static SENSOR_DEVICE_ATTR_RO(temp5_fault, temp_fault, 4);
+static SENSOR_DEVICE_ATTR_RO(temp6_fault, temp_fault, 5);

 static struct attribute *pc87427_attributes_temp[6][10] = {
 	{
diff -u -p a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -123,7 +123,7 @@ struct w83l785ts_data {
  * Sysfs stuff
  */

-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
+static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 	char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -131,8 +131,8 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_max, temp, 1);

 /*
  * Real code
diff -u -p a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -688,7 +688,7 @@ static int rv3029_read_temp(struct devic
 	return 0;
 }

-static ssize_t rv3029_hwmon_show_temp(struct device *dev,
+static ssize_t rv3029_hwmon_temp_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
@@ -701,10 +701,10 @@ static ssize_t rv3029_hwmon_show_temp(st
 	return sprintf(buf, "%d\n", temp_mC);
 }

-static ssize_t rv3029_hwmon_set_update_interval(struct device *dev,
-						struct device_attribute *attr,
-						const char *buf,
-						size_t count)
+static ssize_t rv3029_hwmon_update_interval_store(struct device *dev,
+						  struct device_attribute *attr,
+						  const char *buf,
+						  size_t count)
 {
 	unsigned long interval_ms;
 	int ret;
@@ -728,7 +728,7 @@ static ssize_t rv3029_hwmon_set_update_i
 	return count;
 }

-static ssize_t rv3029_hwmon_show_update_interval(struct device *dev,
+static ssize_t rv3029_hwmon_update_interval_show(struct device *dev,
 						 struct device_attribute *attr,
 						 char *buf)
 {
@@ -752,11 +752,8 @@ static ssize_t rv3029_hwmon_show_update_
 	return sprintf(buf, "%d\n", interval_ms);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, rv3029_hwmon_show_temp,
-			  NULL, 0);
-static SENSOR_DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO,
-			  rv3029_hwmon_show_update_interval,
-			  rv3029_hwmon_set_update_interval, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, rv3029_hwmon_temp, 0);
+static SENSOR_DEVICE_ATTR_RW(update_interval, rv3029_hwmon_update_interval, 0);

 static struct attribute *rv3029_hwmon_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -952,7 +952,7 @@ static int ds3231_hwmon_read_temp(struct
 	return 0;
 }

-static ssize_t ds3231_hwmon_show_temp(struct device *dev,
+static ssize_t ds3231_hwmon_temp_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
@@ -964,8 +964,7 @@ static ssize_t ds3231_hwmon_show_temp(st

 	return sprintf(buf, "%d\n", temp);
 }
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ds3231_hwmon_show_temp,
-			NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, ds3231_hwmon_temp, 0);

 static struct attribute *ds3231_hwmon_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/net/wireless/ath/ath10k/thermal.c b/drivers/net/wireless/ath/ath10k/thermal.c
--- a/drivers/net/wireless/ath/ath10k/thermal.c
+++ b/drivers/net/wireless/ath/ath10k/thermal.c
@@ -69,7 +69,7 @@ static struct thermal_cooling_device_ops
 	.set_cur_state = ath10k_thermal_set_cur_throttle_state,
 };

-static ssize_t ath10k_thermal_show_temp(struct device *dev,
+static ssize_t ath10k_thermal_temp_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
@@ -124,8 +124,7 @@ void ath10k_thermal_event_temperature(st
 	complete(&ar->thermal.wmi_sync);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, ath10k_thermal_show_temp,
-			  NULL, 0);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, ath10k_thermal_temp, 0);

 static struct attribute *ath10k_hwmon_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c
@@ -1257,7 +1257,7 @@ static struct bin_attribute bin_attr_fla

 #ifdef CONFIG_QLCNIC_HWMON

-static ssize_t qlcnic_hwmon_show_temp(struct device *dev,
+static ssize_t qlcnic_hwmon_temp_show(struct device *dev,
 				      struct device_attribute *dev_attr,
 				      char *buf)
 {
@@ -1276,8 +1276,7 @@ static ssize_t qlcnic_hwmon_show_temp(st
 }

 /* hwmon-sysfs attributes */
-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
-			  qlcnic_hwmon_show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, qlcnic_hwmon_temp, 1);

 static struct attribute *qlcnic_hwmon_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5770,7 +5770,7 @@ static void be_remove(struct pci_dev *pd
 	free_netdev(adapter->netdev);
 }

-static ssize_t be_hwmon_show_temp(struct device *dev,
+static ssize_t be_hwmon_temp_show(struct device *dev,
 				  struct device_attribute *dev_attr,
 				  char *buf)
 {
@@ -5784,8 +5784,7 @@ static ssize_t be_hwmon_show_temp(struct
 			       adapter->hwmon_info.be_on_die_temp * 1000);
 }

-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
-			  be_hwmon_show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, be_hwmon_temp, 1);

 static struct attribute *be_hwmon_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -10757,7 +10757,7 @@ static void tg3_sd_scan_scratchpad(struc
 }

 /* sysfs attributes for hwmon */
-static ssize_t tg3_show_temp(struct device *dev,
+static ssize_t tg3_temp_show(struct device *dev,
 			     struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
@@ -10772,12 +10772,9 @@ static ssize_t tg3_show_temp(struct devi
 }


-static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, tg3_show_temp, NULL,
-			  TG3_TEMP_SENSOR_OFFSET);
-static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, tg3_show_temp, NULL,
-			  TG3_TEMP_CAUTION_OFFSET);
-static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, tg3_show_temp, NULL,
-			  TG3_TEMP_MAX_OFFSET);
+static SENSOR_DEVICE_ATTR_RO(temp1_input, tg3_temp, TG3_TEMP_SENSOR_OFFSET);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit, tg3_temp, TG3_TEMP_CAUTION_OFFSET);
+static SENSOR_DEVICE_ATTR_RO(temp1_max, tg3_temp, TG3_TEMP_MAX_OFFSET);

 static struct attribute *tg3_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
--- a/drivers/misc/ds1682.c
+++ b/drivers/misc/ds1682.c
@@ -119,12 +119,9 @@ static ssize_t ds1682_store(struct devic
 /*
  * Simple register attributes
  */
-static SENSOR_DEVICE_ATTR_2(elapsed_time, S_IRUGO | S_IWUSR, ds1682_show,
-			    ds1682_store, 4, DS1682_REG_ELAPSED);
-static SENSOR_DEVICE_ATTR_2(alarm_time, S_IRUGO | S_IWUSR, ds1682_show,
-			    ds1682_store, 4, DS1682_REG_ALARM);
-static SENSOR_DEVICE_ATTR_2(event_count, S_IRUGO | S_IWUSR, ds1682_show,
-			    ds1682_store, 2, DS1682_REG_EVT_CNTR);
+static SENSOR_DEVICE_ATTR_2_RW(elapsed_time, ds1682, 4, DS1682_REG_ELAPSED);
+static SENSOR_DEVICE_ATTR_2_RW(alarm_time, ds1682, 4, DS1682_REG_ALARM);
+static SENSOR_DEVICE_ATTR_2_RW(event_count, ds1682, 2, DS1682_REG_EVT_CNTR);

 static const struct attribute_group ds1682_group = {
 	.attrs = (struct attribute *[]) {
