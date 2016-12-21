From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 21 Dec 2016 15:05:37 +0100 (CET)
Subject: [Cocci] Converting DEVICE_ATTR to DEVICE_ATTR_{RO, RW,
 WO} and changing function names at the same time
In-Reply-To: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
References: <0bcce41c-88ce-09a0-2ddd-5ba2e406d482@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1612211434221.3084@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A solution is below: the semantic patch, an explanation of the semantic
patch, and the results.  I have only tried to compile the results (make
drivers/hwmon/).  Two affected files were not considered for compilation:

drivers/hwmon/vexpress-hwmon.o
drivers/hwmon/jz4740-hwmon.o

All the other affected files obtained .o files with no compiler errors or
warnings.

There are a few cases that are not handled:

1. Calls like the following, where the attribute name is not an
identifier:

adm1026.c:static DEVICE_ATTR(temp##offset##_crit_enable, ...)

2.  Calls like the following, where the function name is constructed using
a macro:

gl518sm.c:static DEVICE_ATTR(in0_min, S_IWUSR|S_IRUGO, show_in_min0,
set_in_min1);

3.  Calls, like the following, where a function name is reused:

adm1026.c:static DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, pwm1_show,
pwm1_store);

In the third case, it does treat one use, but not the others.  For
example, DEVICE_ATTR_RW(pwm1); is generated in this case.  Another
approach would be to do no transformation, ie not transform the pwm1 case
as well.

It is possible that the transformation will change the number of
characters in a function name, causing the parameter or argument list to
become unaligned.  The semantic patch thus removes and adds back the
argument or parameter list, using the Coccinelle defaults for indentation.
This means that the arguments are parameters are lined up with the right
side of the (.  Another option would be to leave the argument or parameter
list as is.  In particular, it seems that the original code often just
puts a few tabs for the continuation line, rather than trying to align the
arguments or parameters, so perhaps the Coccinelle defaults are not what
is wanted.  It is easy to remove what Coccinelle does, but then some code
may need to be adjusted by hand.

I haven't checked the resulting patch very carefully, so this is more a
request for comments rather than a patch submission.  I can also break up
the patch by file or by set of maintainers, if that would be useful.

I guess it would be easy to adapt all this to the SENSOR case.

julia

--------------------------------------------------------------------------
@initialize:ocaml@
@@

let taken = Hashtbl.create 101

// -------------------------------------------------------------------------
// Easy case

@d@
declarer name DEVICE_ATTR;
identifier x;
@@

DEVICE_ATTR(x,...);

@script:ocaml depends on d@
@@

Hashtbl.clear taken

@script:ocaml expected@
x << d.x;
x_show;
x_store;
@@
x_show := make_ident (x^"_show");
x_store := make_ident (x^"_store")

@@
declarer name DEVICE_ATTR_RO;
identifier d.x,expected.x_show;
@@

- DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);
+ DEVICE_ATTR_RO(x);

@@
declarer name DEVICE_ATTR_WO;
identifier d.x,expected.x_store;
@@

- DEVICE_ATTR(x, \(0200\|S_IWUSR\), NULL, x_store);
+ DEVICE_ATTR_WO(x);

@@
declarer name DEVICE_ATTR_RW;
identifier d.x,expected.x_show,expected.x_store;
@@

- DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
+ DEVICE_ATTR_RW(x);

// -------------------------------------------------------------------------
// Other calls

@o@
declarer name DEVICE_ATTR;
identifier d.x,show,store;
@@

DEVICE_ATTR(x,\(0444\|S_IRUGO\|0200\|S_IWUSR\|0644\|S_IRUGO|S_IWUSR\),
            show,store);

@script:ocaml@
x << d.x;
show << o.show;
store << o.store;
@@

if (not(show = "NULL") && Hashtbl.mem taken show) ||
   (not(store = "NULL") && Hashtbl.mem taken store)
then Coccilib.include_match false
else (Hashtbl.add taken show (); Hashtbl.add taken store ())

// rename functions

@show1@
identifier o.show,expected.x_show;
parameter list ps;
@@

static
- show(ps)
+ x_show(ps)
  { ... }

@depends on show1@
identifier o.show,expected.x_show;
expression list es;
@@
- show(es)
+ x_show(es)

@depends on show1@
identifier o.show,expected.x_show;
@@
- show
+ x_show

@store1@
identifier o.store,expected.x_store;
parameter list ps;
@@

static
- store(ps)
+ x_store(ps)
  { ... }

@depends on store1@
identifier o.store,expected.x_store;
expression list es;
@@
- store(es)
+ x_store(es)

@depends on store1@
identifier o.store,expected.x_store;
@@
- store
+ x_store

// try again

@@
declarer name DEVICE_ATTR_RO;
identifier d.x,expected.x_show;
@@

- DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);
+ DEVICE_ATTR_RO(x);

@@
declarer name DEVICE_ATTR_WO;
identifier d.x,expected.x_store;
@@

- DEVICE_ATTR(x, \(0200\|S_IWUSR\), NULL, x_store);
+ DEVICE_ATTR_WO(x);

@@
declarer name DEVICE_ATTR_RW;
identifier d.x,expected.x_show,expected.x_store;
@@

- DEVICE_ATTR(x, \(0644\|S_IRUGO|S_IWUSR\), x_show, x_store);
+ DEVICE_ATTR_RW(x);

--------------------------------------------------------------------------

The semantic patch starts by declaring a hash table to use to avoid trying
to change a function name in two different ways.

The section "Easy case" matches a DEVICE_ATTR, then clears the hash table
(not particularly relevant to the easy case, but for performance reasons,
we only want to do this for files that are actually relevant to the
transfromation being considered), then makes the names of the expected
identifiers, and then transforms the calls where the names of the functions
are the expected ones.

The section "Other calls" matches a DEVICE_ATTR again.  All of the easy
case ones have already been transformed, so these are the ones where at
least one of the functions has a name that is problematic.  The next OCaml
rule checks if a name has been chosen for the show or the store function
already.  If so, it does not further process the current call
(Coccilib.include_match false).  If not, it adds the names of the show and
store functions to the hash table so that they will not be processed again.

There are then three rules that update the name of the show function to the
expected one, and then three rules that update the name of the store
function to the expected one.  Note that the function name is only changed
if the function is static, to avoid having to consider the code in other
files.

Now the easy case should apply.  The "try again" section has the same rules
as were found in the "Easy case" section to do the transformation.

The semantic patch is a bit inefficient in two respects:

1.  In the RW case, there are both the show and the store function.  If one
has the expected name and the other does not, the call is in the "Other
calls" case.  The function that already has the expected name will then be
renamed to its current name.

2.  The metavariables show and store might be bound to NULL.  Coccinelle
will then hunt for functions that have the name NULL to try to rename
them.

Both of these entail extra work, but should not lead to incorrect results.

--------------------------------------------------------------------------

diff -u -p a/drivers/hwmon/i5500_temp.c b/drivers/hwmon/i5500_temp.c
--- a/drivers/hwmon/i5500_temp.c
+++ b/drivers/hwmon/i5500_temp.c
@@ -43,8 +43,8 @@
  */

 /* Sensor resolution : 0.5 degree C */
-static ssize_t show_temp(struct device *dev,
-			 struct device_attribute *devattr, char *buf)
+static ssize_t temp1_input_show(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->parent);
 	long temp;
@@ -83,7 +83,7 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (unsigned int)ctsts & (1 << nr));
 }

-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
+static DEVICE_ATTR_RO(temp1_input);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_thresh, NULL, 0xE2);
 static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_thresh, NULL, 0xEC);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_thresh, NULL, 0xEE);
diff -u -p a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -390,8 +390,8 @@ static ssize_t show_pwm_auto_point_temp(
 static ssize_t store_pwm_auto_point_temp(struct device *dev,
 	struct device_attribute *devattr, const char *buf, size_t count);
 /* Sysfs misc */
-static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
-	char *buf);
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf);

 static int f71882fg_probe(struct platform_device *pdev);
 static int f71882fg_remove(struct platform_device *pdev);
@@ -404,7 +404,7 @@ static struct platform_driver f71882fg_d
 	.remove		= f71882fg_remove,
 };

-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 /*
  * Temp attr for the f71858fg, the f71858fg is special as it has its
@@ -2212,8 +2212,8 @@ static ssize_t store_pwm_auto_point_temp
 	return count;
 }

-static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
-	char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%s\n", f71882fg_names[data->type]);
diff -u -p a/drivers/hwmon/vexpress-hwmon.c b/drivers/hwmon/vexpress-hwmon.c
--- a/drivers/hwmon/vexpress-hwmon.c
+++ b/drivers/hwmon/vexpress-hwmon.c
@@ -29,8 +29,9 @@ struct vexpress_hwmon_data {
 	struct regmap *reg;
 };

-static ssize_t vexpress_hwmon_label_show(struct device *dev,
-		struct device_attribute *dev_attr, char *buffer)
+static ssize_t curr1_label_show(struct device *dev,
+				struct device_attribute *dev_attr,
+				char *buffer)
 {
 	const char *label = of_get_property(dev->of_node, "label", NULL);

@@ -79,7 +80,7 @@ static umode_t vexpress_hwmon_attr_is_vi
 	struct device_attribute *dev_attr = container_of(attr,
 				struct device_attribute, attr);

-	if (dev_attr->show == vexpress_hwmon_label_show &&
+	if (dev_attr->show == curr1_label_show &&
 			!of_get_property(dev->of_node, "label", NULL))
 		return 0;

@@ -92,7 +93,7 @@ struct vexpress_hwmon_type {
 };

 #if !defined(CONFIG_REGULATOR_VEXPRESS)
-static DEVICE_ATTR(in1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
+static DEVICE_ATTR(in1_label, S_IRUGO, curr1_label_show, NULL);
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1000);
 static struct attribute *vexpress_hwmon_attrs_volt[] = {
@@ -113,7 +114,7 @@ static struct vexpress_hwmon_type vexpre
 };
 #endif

-static DEVICE_ATTR(curr1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
+static DEVICE_ATTR_RO(curr1_label);
 static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1000);
 static struct attribute *vexpress_hwmon_attrs_amp[] = {
@@ -133,7 +134,7 @@ static struct vexpress_hwmon_type vexpre
 	},
 };

-static DEVICE_ATTR(temp1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
+static DEVICE_ATTR(temp1_label, S_IRUGO, curr1_label_show, NULL);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1000);
 static struct attribute *vexpress_hwmon_attrs_temp[] = {
@@ -153,7 +154,7 @@ static struct vexpress_hwmon_type vexpre
 	},
 };

-static DEVICE_ATTR(power1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
+static DEVICE_ATTR(power1_label, S_IRUGO, curr1_label_show, NULL);
 static SENSOR_DEVICE_ATTR(power1_input, S_IRUGO, vexpress_hwmon_u32_show,
 		NULL, 1);
 static struct attribute *vexpress_hwmon_attrs_power[] = {
@@ -173,7 +174,7 @@ static struct vexpress_hwmon_type vexpre
 	},
 };

-static DEVICE_ATTR(energy1_label, S_IRUGO, vexpress_hwmon_label_show, NULL);
+static DEVICE_ATTR(energy1_label, S_IRUGO, curr1_label_show, NULL);
 static SENSOR_DEVICE_ATTR(energy1_input, S_IRUGO, vexpress_hwmon_u64_show,
 		NULL, 1);
 static struct attribute *vexpress_hwmon_attrs_energy[] = {
diff -u -p a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -200,13 +200,13 @@ static struct gl520_data *gl520_update_d
  * Sysfs stuff
  */

-static ssize_t get_cpu_vid(struct device *dev, struct device_attribute *attr,
-			   char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct gl520_data *data = gl520_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, get_cpu_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

 #define VDD_FROM_REG(val) (((val) * 95 + 2) / 4)
 #define VDD_TO_REG(val) clamp_val((((val) * 4 + 47) / 95), 0, 255)
@@ -381,8 +381,8 @@ static ssize_t get_fan_div(struct device
 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[n]));
 }

-static ssize_t get_fan_off(struct device *dev, struct device_attribute *attr,
-			   char *buf)
+static ssize_t fan1_off_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct gl520_data *data = gl520_update_device(dev);
 	return sprintf(buf, "%d\n", data->fan_off);
@@ -476,8 +476,9 @@ static ssize_t set_fan_div(struct device
 	return count;
 }

-static ssize_t set_fan_off(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t fan1_off_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
 {
 	struct gl520_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -510,8 +511,7 @@ static SENSOR_DEVICE_ATTR(fan1_div, S_IR
 		get_fan_div, set_fan_div, 0);
 static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
 		get_fan_div, set_fan_div, 1);
-static DEVICE_ATTR(fan1_off, S_IRUGO | S_IWUSR,
-		get_fan_off, set_fan_off);
+static DEVICE_ATTR_RW(fan1_off);

 #define TEMP_FROM_REG(val) (((val) - 130) * 1000)
 #define TEMP_TO_REG(val) clamp_val(((((val) < 0 ? \
@@ -596,29 +596,30 @@ static SENSOR_DEVICE_ATTR(temp1_max_hyst
 static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO | S_IWUSR,
 		get_temp_max_hyst, set_temp_max_hyst, 1);

-static ssize_t get_alarms(struct device *dev, struct device_attribute *attr,
-			  char *buf)
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct gl520_data *data = gl520_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }

-static ssize_t get_beep_enable(struct device *dev, struct device_attribute
-			       *attr, char *buf)
+static ssize_t beep_enable_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct gl520_data *data = gl520_update_device(dev);
 	return sprintf(buf, "%d\n", data->beep_enable);
 }

-static ssize_t get_beep_mask(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t beep_mask_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct gl520_data *data = gl520_update_device(dev);
 	return sprintf(buf, "%d\n", data->beep_mask);
 }

-static ssize_t set_beep_enable(struct device *dev, struct device_attribute
-			       *attr, const char *buf, size_t count)
+static ssize_t beep_enable_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct gl520_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -641,8 +642,9 @@ static ssize_t set_beep_enable(struct de
 	return count;
 }

-static ssize_t set_beep_mask(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t beep_mask_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
 {
 	struct gl520_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -661,11 +663,9 @@ static ssize_t set_beep_mask(struct devi
 	return count;
 }

-static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
-static DEVICE_ATTR(beep_enable, S_IRUGO | S_IWUSR,
-		get_beep_enable, set_beep_enable);
-static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR,
-		get_beep_mask, set_beep_mask);
+static DEVICE_ATTR_RO(alarms);
+static DEVICE_ATTR_RW(beep_enable);
+static DEVICE_ATTR_RW(beep_mask);

 static ssize_t get_alarm(struct device *dev, struct device_attribute *attr,
 			 char *buf)
diff -u -p a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -72,8 +72,8 @@ static void amd_nb_smu_index_read(struct
 	mutex_unlock(&nb_smu_ind_mutex);
 }

-static ssize_t show_temp(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t temp1_input_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	u32 regval;
 	struct pci_dev *pdev = dev_get_drvdata(dev);
@@ -88,8 +88,8 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%u\n", (regval >> 21) * 125);
 }

-static ssize_t show_temp_max(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t temp1_max_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%d\n", 70 * 1000);
 }
@@ -110,8 +110,8 @@ static ssize_t show_temp_crit(struct dev
 	return sprintf(buf, "%d\n", value);
 }

-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
-static DEVICE_ATTR(temp1_max, S_IRUGO, show_temp_max, NULL);
+static DEVICE_ATTR_RO(temp1_input);
+static DEVICE_ATTR_RO(temp1_max);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit, NULL, 1);

diff -u -p a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -188,7 +188,7 @@ static ssize_t set_temp(struct device *d
 	return count;
 }

-static ssize_t show_alarms(struct device *dev, struct device_attribute *dummy,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *dummy,
 			   char *buf)
 {
 	struct lm83_data *data = lm83_update_device(dev);
@@ -236,7 +236,7 @@ static SENSOR_DEVICE_ATTR(temp4_max_alar
 static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 13);
 static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 15);
 /* Raw alarm file for compatibility */
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static struct attribute *lm83_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -403,7 +403,7 @@ out:
 	return data;
 }

-static ssize_t show_auto_update_interval(struct device *dev,
+static ssize_t auto_update_interval_show(struct device *dev,
 					 struct device_attribute *devattr,
 					 char *buf)
 {
@@ -411,10 +411,9 @@ static ssize_t show_auto_update_interval
 	return sprintf(buf, "%d\n", data->auto_update_interval);
 }

-static ssize_t set_auto_update_interval(struct device *dev,
-					struct device_attribute *devattr,
-					const char *buf,
-					size_t count)
+static ssize_t auto_update_interval_store(struct device *dev,
+					  struct device_attribute *devattr,
+					  const char *buf, size_t count)
 {
 	struct adt7470_data *data = dev_get_drvdata(dev);
 	long temp;
@@ -431,7 +430,7 @@ static ssize_t set_auto_update_interval(
 	return count;
 }

-static ssize_t show_num_temp_sensors(struct device *dev,
+static ssize_t num_temp_sensors_show(struct device *dev,
 				     struct device_attribute *devattr,
 				     char *buf)
 {
@@ -439,10 +438,9 @@ static ssize_t show_num_temp_sensors(str
 	return sprintf(buf, "%d\n", data->num_temp_sensors);
 }

-static ssize_t set_num_temp_sensors(struct device *dev,
-				    struct device_attribute *devattr,
-				    const char *buf,
-				    size_t count)
+static ssize_t num_temp_sensors_store(struct device *dev,
+				      struct device_attribute *devattr,
+				      const char *buf, size_t count)
 {
 	struct adt7470_data *data = dev_get_drvdata(dev);
 	long temp;
@@ -537,19 +535,17 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", 1000 * data->temp[attr->index]);
 }

-static ssize_t show_alarm_mask(struct device *dev,
-			   struct device_attribute *devattr,
-			   char *buf)
+static ssize_t alarm_mask_show(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
 {
 	struct adt7470_data *data = adt7470_update_device(dev);

 	return sprintf(buf, "%x\n", data->alarms_mask);
 }

-static ssize_t set_alarm_mask(struct device *dev,
-			      struct device_attribute *devattr,
-			      const char *buf,
-			      size_t count)
+static ssize_t alarm_mask_store(struct device *dev,
+				struct device_attribute *devattr,
+				const char *buf, size_t count)
 {
 	struct adt7470_data *data = dev_get_drvdata(dev);
 	long mask;
@@ -723,8 +719,8 @@ static const int adt7470_freq_map[] = {
 	11, 15, 22, 29, 35, 44, 59, 88, 1400, 22500
 };

-static ssize_t show_pwm_freq(struct device *dev,
-			     struct device_attribute *devattr, char *buf)
+static ssize_t pwm1_freq_show(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
 	struct adt7470_data *data = adt7470_update_device(dev);
 	unsigned char cfg_reg_1;
@@ -745,9 +741,9 @@ static ssize_t show_pwm_freq(struct devi
 	return scnprintf(buf, PAGE_SIZE, "%d\n", adt7470_freq_map[index]);
 }

-static ssize_t set_pwm_freq(struct device *dev,
-			    struct device_attribute *devattr,
-			    const char *buf, size_t count)
+static ssize_t pwm1_freq_store(struct device *dev,
+			       struct device_attribute *devattr,
+			       const char *buf, size_t count)
 {
 	struct adt7470_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -1012,12 +1008,9 @@ static ssize_t show_alarm(struct device
 		return sprintf(buf, "0\n");
 }

-static DEVICE_ATTR(alarm_mask, S_IWUSR | S_IRUGO, show_alarm_mask,
-		   set_alarm_mask);
-static DEVICE_ATTR(num_temp_sensors, S_IWUSR | S_IRUGO, show_num_temp_sensors,
-		   set_num_temp_sensors);
-static DEVICE_ATTR(auto_update_interval, S_IWUSR | S_IRUGO,
-		   show_auto_update_interval, set_auto_update_interval);
+static DEVICE_ATTR_RW(alarm_mask);
+static DEVICE_ATTR_RW(num_temp_sensors);
+static DEVICE_ATTR_RW(auto_update_interval);

 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_max,
 		    set_temp_max, 0);
@@ -1133,7 +1126,7 @@ static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR
 static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 2);
 static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, set_pwm, 3);

-static DEVICE_ATTR(pwm1_freq, S_IWUSR | S_IRUGO, show_pwm_freq, set_pwm_freq);
+static DEVICE_ATTR_RW(pwm1_freq);

 static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
 		    show_pwm_min, set_pwm_min, 0);
diff -u -p a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
--- a/drivers/hwmon/mcp3021.c
+++ b/drivers/hwmon/mcp3021.c
@@ -86,8 +86,8 @@ static inline u16 volts_from_reg(struct
 	return DIV_ROUND_CLOSEST(data->vdd * val, 1 << data->output_res);
 }

-static ssize_t show_in_input(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t in0_input_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct mcp3021_data *data = i2c_get_clientdata(client);
@@ -102,7 +102,7 @@ static ssize_t show_in_input(struct devi
 	return sprintf(buf, "%d\n", in_input);
 }

-static DEVICE_ATTR(in0_input, 0444, show_in_input, NULL);
+static DEVICE_ATTR_RO(in0_input);

 static int mcp3021_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
diff -u -p a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -114,14 +114,14 @@ struct i5k_amb_data {
 	unsigned int num_attrs;
 };

-static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
 	return sprintf(buf, "%s\n", DRVNAME);
 }


-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static struct platform_device *amb_pdev;

diff -u -p a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -173,7 +173,7 @@ static ssize_t set_temp(struct device *d
 	return count;
 }

-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct max1619_data *data = max1619_update_device(dev);
@@ -199,7 +199,7 @@ static SENSOR_DEVICE_ATTR(temp2_crit, S_
 static SENSOR_DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp,
 			  set_temp, t_hyst2);

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);
 static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_alarm, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
diff -u -p a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -100,8 +100,8 @@ static struct k8temp_data *k8temp_update
  * Sysfs stuff
  */

-static ssize_t show_name(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct k8temp_data *data = dev_get_drvdata(dev);

@@ -133,7 +133,7 @@ static SENSOR_DEVICE_ATTR_2(temp1_input,
 static SENSOR_DEVICE_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1);
 static SENSOR_DEVICE_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 1, 0);
 static SENSOR_DEVICE_ATTR_2(temp4_input, S_IRUGO, show_temp, NULL, 1, 1);
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static const struct pci_device_id k8temp_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB_MISC) },
diff -u -p a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -333,12 +333,12 @@ set_temp(1);
 set_temp(2);

 static ssize_t
-show_alarms(struct device *dev, struct device_attribute *attr, char *buf)
+alarms_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t
 show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
@@ -358,21 +358,21 @@ static SENSOR_DEVICE_ATTR(temp2_alarm, S
 static SENSOR_DEVICE_ATTR(temp1_fault, S_IRUGO, show_alarm, NULL, 14);

 static ssize_t
-show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+cpu0_vid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = adm1025_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

 static ssize_t
-show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
+vrm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct adm1025_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct adm1025_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -388,7 +388,7 @@ static ssize_t set_vrm(struct device *de
 	data->vrm = val;
 	return count;
 }
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+static DEVICE_ATTR_RW(vrm);

 /*
  * Real code
diff -u -p a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -205,8 +205,8 @@ static int reg_to_rpm(u16 reg)
 	return 5400540 / reg;
 }

-static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
-	char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	return snprintf(buf, PAGE_SIZE, "%s\n", DEVNAME);
 }
@@ -326,7 +326,7 @@ static ssize_t show_in_label(struct devi
 			SCH5627_IN_LABELS[attr->index]);
 }

-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);
 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
diff -u -p a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -81,8 +81,8 @@ static struct atxp1_data *atxp1_update_d
 }

 /* sys file functions for cpu0_vid */
-static ssize_t atxp1_showvcore(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -95,9 +95,9 @@ static ssize_t atxp1_showvcore(struct de
 	return size;
 }

-static ssize_t atxp1_storevcore(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
+static ssize_t cpu0_vid_store(struct device *dev,
+			      struct device_attribute *attr, const char *buf,
+			      size_t count)
 {
 	struct atxp1_data *data = atxp1_update_device(dev);
 	struct i2c_client *client = data->client;
@@ -154,12 +154,11 @@ static ssize_t atxp1_storevcore(struct d
  * CPU core reference voltage
  * unit: millivolt
  */
-static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore,
-		   atxp1_storevcore);
+static DEVICE_ATTR_RW(cpu0_vid);

 /* sys file functions for GPIO1 */
-static ssize_t atxp1_showgpio1(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t gpio1_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -171,9 +170,8 @@ static ssize_t atxp1_showgpio1(struct de
 	return size;
 }

-static ssize_t atxp1_storegpio1(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
+static ssize_t gpio1_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct atxp1_data *data = atxp1_update_device(dev);
 	struct i2c_client *client = data->client;
@@ -201,11 +199,11 @@ static ssize_t atxp1_storegpio1(struct d
  * GPIO1 data register
  * unit: Four bit as hex (e.g. 0x0f)
  */
-static DEVICE_ATTR(gpio1, S_IRUGO | S_IWUSR, atxp1_showgpio1, atxp1_storegpio1);
+static DEVICE_ATTR_RW(gpio1);

 /* sys file functions for GPIO2 */
-static ssize_t atxp1_showgpio2(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t gpio2_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	int size;
 	struct atxp1_data *data;
@@ -217,9 +215,8 @@ static ssize_t atxp1_showgpio2(struct de
 	return size;
 }

-static ssize_t atxp1_storegpio2(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
+static ssize_t gpio2_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct atxp1_data *data = atxp1_update_device(dev);
 	struct i2c_client *client = data->client;
@@ -246,7 +243,7 @@ static ssize_t atxp1_storegpio2(struct d
  * GPIO2 data register
  * unit: Eight bit as hex (e.g. 0xff)
  */
-static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);
+static DEVICE_ATTR_RW(gpio2);

 static struct attribute *atxp1_attrs[] = {
 	&dev_attr_gpio1.attr,
diff -u -p a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -445,23 +445,23 @@ set_temp(1);
 set_temp(2);
 set_temp(3);

-static ssize_t show_temp_crit_int(struct device *dev,
-				  struct device_attribute *attr, char *buf)
+static ssize_t temp1_crit_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit_int));
 }

-static ssize_t show_temp_crit_ext(struct device *dev,
-				  struct device_attribute *attr, char *buf)
+static ssize_t temp2_crit_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_crit_ext));
 }

-static DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit_int, NULL);
-static DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp_crit_ext, NULL);
-static DEVICE_ATTR(temp3_crit, S_IRUGO, show_temp_crit_ext, NULL);
+static DEVICE_ATTR_RO(temp1_crit);
+static DEVICE_ATTR_RO(temp2_crit);
+static DEVICE_ATTR(temp3_crit, S_IRUGO, temp2_crit_show, NULL);

 static ssize_t show_fan_input(struct device *dev,
 			      struct device_attribute *attr, char *buf)
@@ -586,30 +586,30 @@ static SENSOR_DEVICE_ATTR(fan##offset##_
 set_fan(1);
 set_fan(2);

-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

-static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
-			char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
+static ssize_t vrm_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct lm87_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct lm87_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -625,16 +625,17 @@ static ssize_t set_vrm(struct device *de
 	data->vrm = val;
 	return count;
 }
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+static DEVICE_ATTR_RW(vrm);

-static ssize_t show_aout(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static ssize_t aout_output_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct lm87_data *data = lm87_update_device(dev);
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }
-static ssize_t set_aout(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t aout_output_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct i2c_client *client = dev_get_drvdata(dev);
 	struct lm87_data *data = i2c_get_clientdata(client);
@@ -651,7 +652,7 @@ static ssize_t set_aout(struct device *d
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
+static DEVICE_ATTR_RW(aout_output);

 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 			  char *buf)
diff -u -p a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -578,7 +578,7 @@ static ssize_t store_temp23(struct devic

 /* get realtime status of all sensors items: voltage, temp, fan */
 static ssize_t
-show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
+alarms_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83792d_data *data = w83792d_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
@@ -735,16 +735,16 @@ store_pwm_mode(struct device *dev, struc
 }

 static ssize_t
-show_chassis_clear(struct device *dev, struct device_attribute *attr,
-			char *buf)
+intrusion0_alarm_show(struct device *dev, struct device_attribute *attr,
+		      char *buf)
 {
 	struct w83792d_data *data = w83792d_update_device(dev);
 	return sprintf(buf, "%d\n", data->chassis);
 }

 static ssize_t
-store_chassis_clear(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+intrusion0_alarm_store(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct w83792d_data *data = i2c_get_clientdata(client);
@@ -1047,7 +1047,7 @@ static SENSOR_DEVICE_ATTR_2(temp2_max_hy
 			show_temp23, store_temp23, 0, 4);
 static SENSOR_DEVICE_ATTR_2(temp3_max_hyst, S_IRUGO | S_IWUSR,
 			show_temp23, store_temp23, 1, 4);
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
+static DEVICE_ATTR_RO(alarms);
 static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
 static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 2);
@@ -1067,8 +1067,7 @@ static SENSOR_DEVICE_ATTR(in8_alarm, S_I
 static SENSOR_DEVICE_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 21);
 static SENSOR_DEVICE_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 22);
 static SENSOR_DEVICE_ATTR(fan6_alarm, S_IRUGO, show_alarm, NULL, 23);
-static DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR,
-			show_chassis_clear, store_chassis_clear);
+static DEVICE_ATTR_RW(intrusion0_alarm);
 static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0);
 static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1);
 static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2);
diff -u -p a/drivers/hwmon/nsa320-hwmon.c b/drivers/hwmon/nsa320-hwmon.c
--- a/drivers/hwmon/nsa320-hwmon.c
+++ b/drivers/hwmon/nsa320-hwmon.c
@@ -122,8 +122,8 @@ static ssize_t show_label(struct device
 	return sprintf(buf, "%s\n", nsa320_input_names[channel]);
 }

-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static ssize_t temp1_input_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	s32 mcu_data = nsa320_hwmon_update(dev);

@@ -133,8 +133,8 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%d\n", (mcu_data & 0xffff) * 100);
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
-			char *buf)
+static ssize_t fan1_input_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	s32 mcu_data = nsa320_hwmon_update(dev);

@@ -145,9 +145,9 @@ static ssize_t show_fan(struct device *d
 }

 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL, NSA320_TEMP);
-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
+static DEVICE_ATTR_RO(temp1_input);
 static SENSOR_DEVICE_ATTR(fan1_label, S_IRUGO, show_label, NULL, NSA320_FAN);
-static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL);
+static DEVICE_ATTR_RO(fan1_input);

 static struct attribute *nsa320_attrs[] = {
 	&sensor_dev_attr_temp1_label.dev_attr.attr,
diff -u -p a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1762,14 +1762,14 @@ static SENSOR_DEVICE_ATTR(pwm6_auto_slop
 			  show_auto_pwm_slope, set_auto_pwm_slope, 5);

 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);

 	return sprintf(buf, "%u\n", data->alarms);
 }
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -1877,16 +1877,16 @@ static SENSOR_DEVICE_ATTR(temp1_beep, S_
 static SENSOR_DEVICE_ATTR(temp2_beep, S_IRUGO, show_beep, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp3_beep, S_IRUGO, show_beep, NULL, 2);

-static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t vrm_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct it87_data *data = dev_get_drvdata(dev);

 	return sprintf(buf, "%u\n", data->vrm);
 }

-static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct it87_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -1898,16 +1898,16 @@ static ssize_t store_vrm_reg(struct devi

 	return count;
 }
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
+static DEVICE_ATTR_RW(vrm);

-static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct it87_data *data = it87_update_device(dev);

 	return sprintf(buf, "%ld\n", (long)vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

 static ssize_t show_label(struct device *dev, struct device_attribute *attr,
 			  char *buf)
diff -u -p a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -829,14 +829,14 @@ temp_reg(2);
 temp_reg(3);

 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct adm1031_data *data = adm1031_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarm);
 }

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev,
 			  struct device_attribute *attr, char *buf)
@@ -867,7 +867,7 @@ static const unsigned int update_interva
 	16000, 8000, 4000, 2000, 1000, 500, 250, 125,
 };

-static ssize_t show_update_interval(struct device *dev,
+static ssize_t update_interval_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct adm1031_data *data = dev_get_drvdata(dev);
@@ -875,9 +875,9 @@ static ssize_t show_update_interval(stru
 	return sprintf(buf, "%u\n", data->update_interval);
 }

-static ssize_t set_update_interval(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
+static ssize_t update_interval_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
 {
 	struct adm1031_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -912,8 +912,7 @@ static ssize_t set_update_interval(struc
 	return count;
 }

-static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
-		   set_update_interval);
+static DEVICE_ATTR_RW(update_interval);

 static struct attribute *adm1031_attributes[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -830,7 +830,7 @@ static u16 temp_to_u16_adt7461(struct lm
 }

 /* pec used for ADM1032 only */
-static ssize_t show_pec(struct device *dev, struct device_attribute *dummy,
+static ssize_t pec_show(struct device *dev, struct device_attribute *dummy,
 			char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -838,8 +838,8 @@ static ssize_t show_pec(struct device *d
 	return sprintf(buf, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
 }

-static ssize_t set_pec(struct device *dev, struct device_attribute *dummy,
-		       const char *buf, size_t count)
+static ssize_t pec_store(struct device *dev, struct device_attribute *dummy,
+			 const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	long val;
@@ -863,7 +863,7 @@ static ssize_t set_pec(struct device *de
 	return count;
 }

-static DEVICE_ATTR(pec, S_IWUSR | S_IRUGO, show_pec, set_pec);
+static DEVICE_ATTR_RW(pec);

 static int lm90_get_temp11(struct lm90_data *data, int index)
 {
diff -u -p a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -432,7 +432,7 @@ static ssize_t set_temp(struct device *d
 	return count;
 }

-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
@@ -505,7 +505,7 @@ static SENSOR_DEVICE_ATTR(temp1_crit, S_
 		set_temp, t_os_max);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IWUSR | S_IRUGO, show_temp,
 		set_temp, t_os_hyst);
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);
 static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
 static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
diff -u -p a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
--- a/drivers/hwmon/tmp401.c
+++ b/drivers/hwmon/tmp401.c
@@ -449,7 +449,7 @@ static ssize_t reset_temp_history(struct
 	return count;
 }

-static ssize_t show_update_interval(struct device *dev,
+static ssize_t update_interval_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct tmp401_data *data = dev_get_drvdata(dev);
@@ -457,9 +457,9 @@ static ssize_t show_update_interval(stru
 	return sprintf(buf, "%u\n", data->update_interval);
 }

-static ssize_t set_update_interval(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
+static ssize_t update_interval_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
 {
 	struct tmp401_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -521,8 +521,7 @@ static SENSOR_DEVICE_ATTR_2(temp2_max_al
 static SENSOR_DEVICE_ATTR_2(temp2_crit_alarm, S_IRUGO, show_status, NULL,
 			    3, TMP432_STATUS_REMOTE1);

-static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
-		   set_update_interval);
+static DEVICE_ATTR_RW(update_interval);

 static struct attribute *tmp401_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -1041,14 +1041,14 @@ static struct sensor_device_attribute sd
 };

 /* get realtime status of all sensors items: voltage, temp, fan */
-static ssize_t show_alarms_reg(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct w83791d_data *data = w83791d_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
+static DEVICE_ATTR_RO(alarms);

 /* Beep control */

@@ -1147,25 +1147,24 @@ static struct sensor_device_attribute sd
 };

 /* cpu voltage regulation information */
-static ssize_t show_vid_reg(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct w83791d_data *data = w83791d_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }

-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

-static ssize_t show_vrm_reg(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t vrm_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct w83791d_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }

-static ssize_t store_vrm_reg(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct w83791d_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -1188,7 +1187,7 @@ static ssize_t store_vrm_reg(struct devi
 	return count;
 }

-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
+static DEVICE_ATTR_RW(vrm);

 #define IN_UNIT_ATTRS(X) \
 	&sda_in_input[X].dev_attr.attr,	\
diff -u -p a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -263,7 +263,7 @@ static ssize_t set_temp(struct device *d
 	return count;
 }

-static ssize_t show_alarms(struct device *dev, struct device_attribute *da,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *da,
 			   char *buf)
 {
 	struct ds1621_data *data = ds1621_update_client(dev);
@@ -278,15 +278,16 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%d\n", !!(data->conf & attr->index));
 }

-static ssize_t show_convrate(struct device *dev, struct device_attribute *da,
-			  char *buf)
+static ssize_t update_interval_show(struct device *dev,
+				    struct device_attribute *da, char *buf)
 {
 	struct ds1621_data *data = dev_get_drvdata(dev);
 	return scnprintf(buf, PAGE_SIZE, "%hu\n", data->update_interval);
 }

-static ssize_t set_convrate(struct device *dev, struct device_attribute *da,
-			    const char *buf, size_t count)
+static ssize_t update_interval_store(struct device *dev,
+				     struct device_attribute *da,
+				     const char *buf, size_t count)
 {
 	struct ds1621_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -315,9 +316,8 @@ static ssize_t set_convrate(struct devic
 	return count;
 }

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
-static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_convrate,
-		   set_convrate);
+static DEVICE_ATTR_RO(alarms);
+static DEVICE_ATTR_RW(update_interval);

 static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp, 1);
diff -u -p a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -324,7 +324,7 @@ static struct i2c_driver w83793_driver =
 };

 static ssize_t
-show_vrm(struct device *dev, struct device_attribute *attr, char *buf)
+vrm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83793_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
@@ -342,8 +342,8 @@ show_vid(struct device *dev, struct devi
 }

 static ssize_t
-store_vrm(struct device *dev, struct device_attribute *attr,
-	  const char *buf, size_t count)
+vrm_store(struct device *dev, struct device_attribute *attr, const char *buf,
+	  size_t count)
 {
 	struct w83793_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -1169,7 +1169,7 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_2(cpu0_vid, S_IRUGO, show_vid, NULL, NOT_USED, 0),
 	SENSOR_ATTR_2(cpu1_vid, S_IRUGO, show_vid, NULL, NOT_USED, 1),
 };
-static DEVICE_ATTR(vrm, S_IWUSR | S_IRUGO, show_vrm, store_vrm);
+static DEVICE_ATTR_RW(vrm);

 static struct sensor_device_attribute_2 sda_single_files[] = {
 	SENSOR_ATTR_2(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm_beep,
diff -u -p a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -589,22 +589,22 @@ static struct sensor_device_attribute in
 	&in_min_alarm[X].dev_attr.attr,	\
 	&in_max_alarm[X].dev_attr.attr

-static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
-			char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
+static ssize_t vrm_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct pc87360_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%u\n", data->vrm);
 }
-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct pc87360_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -620,15 +620,15 @@ static ssize_t set_vrm(struct device *de
 	data->vrm = val;
 	return count;
 }
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+static DEVICE_ATTR_RW(vrm);

-static ssize_t show_in_alarms(struct device *dev,
+static ssize_t alarms_in_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->in_alarms);
 }
-static DEVICE_ATTR(alarms_in, S_IRUGO, show_in_alarms, NULL);
+static DEVICE_ATTR_RO(alarms_in);

 static struct attribute *pc8736x_vin_attr_array[] = {
 	VIN_UNIT_ATTRS(0),
@@ -1006,14 +1006,14 @@ static struct sensor_device_attribute te
 		    show_temp_crit, set_temp_crit, 2),
 };

-static ssize_t show_temp_alarms(struct device *dev,
+static ssize_t alarms_temp_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct pc87360_data *data = pc87360_update_device(dev);
 	return sprintf(buf, "%u\n", data->temp_alarms);
 }

-static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);
+static DEVICE_ATTR_RO(alarms_temp);

 /*
  * show_temp_min/max_alarm() reads data from the per-channel status
@@ -1106,14 +1106,14 @@ static const struct attribute_group pc87
 	{ .attrs = pc8736x_temp_attr[2] }
 };

-static ssize_t show_name(struct device *dev,
-			struct device_attribute *devattr, char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct pc87360_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%s\n", data->name);
 }

-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 /*
  * Device detection, registration and update
diff -u -p a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -769,8 +769,7 @@ static ssize_t sht15_show_humidity(struc
 	return ret ? ret : sprintf(buf, "%d\n", sht15_calc_humid(data));
 }

-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *attr,
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -787,7 +786,7 @@ static SENSOR_DEVICE_ATTR(humidity1_faul
 			  SHT15_STATUS_LOW_BATTERY);
 static SENSOR_DEVICE_ATTR(heater_enable, S_IRUGO | S_IWUSR, sht15_show_status,
 			  sht15_store_heater, SHT15_STATUS_HEATER);
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);
 static struct attribute *sht15_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
 	&sensor_dev_attr_humidity1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1687,14 +1687,14 @@ store_##reg(struct device *dev, struct d

 fan_time_functions(fan_stop_time, FAN_STOP_TIME)

-static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct w83627ehf_data *data = dev_get_drvdata(dev);

 	return sprintf(buf, "%s\n", data->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static struct sensor_device_attribute sda_sf3_arrays_fan4[] = {
 	SENSOR_ATTR(pwm4_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
@@ -1754,12 +1754,12 @@ static struct sensor_device_attribute sd
 };

 static ssize_t
-show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+cpu0_vid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);


 /* Case open detection */
diff -u -p a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -191,8 +191,7 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%u\n", (data->alarms >> index) & 1);
 }

-static ssize_t show_alarms(struct device *dev,
-			   struct device_attribute *attr,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct adm1021_data *data = adm1021_update_device(dev);
@@ -251,16 +250,16 @@ static ssize_t set_temp_min(struct devic
 	return count;
 }

-static ssize_t show_low_power(struct device *dev,
+static ssize_t low_power_show(struct device *dev,
 			      struct device_attribute *devattr, char *buf)
 {
 	struct adm1021_data *data = adm1021_update_device(dev);
 	return sprintf(buf, "%d\n", data->low_power);
 }

-static ssize_t set_low_power(struct device *dev,
-			     struct device_attribute *devattr,
-			     const char *buf, size_t count)
+static ssize_t low_power_store(struct device *dev,
+			       struct device_attribute *devattr,
+			       const char *buf, size_t count)
 {
 	struct adm1021_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -303,8 +302,8 @@ static SENSOR_DEVICE_ATTR(temp2_max_alar
 static SENSOR_DEVICE_ATTR(temp2_min_alarm, S_IRUGO, show_alarm, NULL, 3);
 static SENSOR_DEVICE_ATTR(temp2_fault, S_IRUGO, show_alarm, NULL, 2);

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
-static DEVICE_ATTR(low_power, S_IWUSR | S_IRUGO, show_low_power, set_low_power);
+static DEVICE_ATTR_RO(alarms);
+static DEVICE_ATTR_RW(low_power);

 static struct attribute *adm1021_attributes[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
diff -u -p a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -979,7 +979,7 @@ static const struct sensor_template_grou
 };

 static ssize_t
-show_global_beep(struct device *dev, struct device_attribute *attr, char *buf)
+beep_enable_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct nct6683_data *data = dev_get_drvdata(dev);
 	int ret;
@@ -1004,7 +1004,7 @@ error:
 }

 static ssize_t
-store_global_beep(struct device *dev, struct device_attribute *attr,
+beep_enable_store(struct device *dev, struct device_attribute *attr,
 		  const char *buf, size_t count)
 {
 	struct nct6683_data *data = dev_get_drvdata(dev);
@@ -1039,7 +1039,8 @@ error:
 /* Case open detection */

 static ssize_t
-show_caseopen(struct device *dev, struct device_attribute *attr, char *buf)
+intrusion0_alarm_show(struct device *dev, struct device_attribute *attr,
+		      char *buf)
 {
 	struct nct6683_data *data = dev_get_drvdata(dev);
 	int ret;
@@ -1064,8 +1065,8 @@ error:
 }

 static ssize_t
-clear_caseopen(struct device *dev, struct device_attribute *attr,
-	       const char *buf, size_t count)
+intrusion0_alarm_store(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
 {
 	struct nct6683_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -1102,10 +1103,8 @@ error:
 	return count;
 }

-static DEVICE_ATTR(intrusion0_alarm, S_IWUSR | S_IRUGO, show_caseopen,
-		   clear_caseopen);
-static DEVICE_ATTR(beep_enable, S_IWUSR | S_IRUGO, show_global_beep,
-		   store_global_beep);
+static DEVICE_ATTR_RW(intrusion0_alarm);
+static DEVICE_ATTR_RW(beep_enable);

 static struct attribute *nct6683_attributes_other[] = {
 	&dev_attr_intrusion0_alarm.attr,
diff -u -p a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -1034,15 +1034,15 @@ temp_crit_reg(1);
 temp_crit_reg(2);
 temp_crit_reg(3);

-static ssize_t show_analog_out_reg(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t analog_out_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", DAC_FROM_REG(data->analog_out));
 }
-static ssize_t set_analog_out_reg(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t analog_out_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -1060,11 +1060,10 @@ static ssize_t set_analog_out_reg(struct
 	return count;
 }

-static DEVICE_ATTR(analog_out, S_IRUGO | S_IWUSR, show_analog_out_reg,
-	set_analog_out_reg);
+static DEVICE_ATTR_RW(analog_out);

-static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	int vid = (data->gpio >> 11) & 0x1f;
@@ -1073,17 +1072,17 @@ static ssize_t show_vid_reg(struct devic
 	return sprintf(buf, "%d\n", vid_from_reg(vid, data->vrm));
 }

-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

-static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t vrm_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }

-static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -1100,16 +1099,16 @@ static ssize_t store_vrm_reg(struct devi
 	return count;
 }

-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
+static DEVICE_ATTR_RW(vrm);

-static ssize_t show_alarms_reg(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->alarms);
 }

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -1148,14 +1147,15 @@ static SENSOR_DEVICE_ATTR(temp1_alarm, S
 static SENSOR_DEVICE_ATTR(in10_alarm, S_IRUGO, show_alarm, NULL, 25);
 static SENSOR_DEVICE_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 26);

-static ssize_t show_alarm_mask(struct device *dev,
+static ssize_t alarm_mask_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->alarm_mask);
 }
-static ssize_t set_alarm_mask(struct device *dev, struct device_attribute *attr,
-			      const char *buf, size_t count)
+static ssize_t alarm_mask_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -1186,18 +1186,17 @@ static ssize_t set_alarm_mask(struct dev
 	return count;
 }

-static DEVICE_ATTR(alarm_mask, S_IRUGO | S_IWUSR, show_alarm_mask,
-	set_alarm_mask);
+static DEVICE_ATTR_RW(alarm_mask);


-static ssize_t show_gpio(struct device *dev, struct device_attribute *attr,
+static ssize_t gpio_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->gpio);
 }
-static ssize_t set_gpio(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t gpio_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -1221,16 +1220,17 @@ static ssize_t set_gpio(struct device *d
 	return count;
 }

-static DEVICE_ATTR(gpio, S_IRUGO | S_IWUSR, show_gpio, set_gpio);
+static DEVICE_ATTR_RW(gpio);

-static ssize_t show_gpio_mask(struct device *dev, struct device_attribute *attr,
-			      char *buf)
+static ssize_t gpio_mask_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%ld\n", data->gpio_mask);
 }
-static ssize_t set_gpio_mask(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t gpio_mask_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -1254,17 +1254,17 @@ static ssize_t set_gpio_mask(struct devi
 	return count;
 }

-static DEVICE_ATTR(gpio_mask, S_IRUGO | S_IWUSR, show_gpio_mask, set_gpio_mask);
+static DEVICE_ATTR_RW(gpio_mask);

-static ssize_t show_pwm_reg(struct device *dev, struct device_attribute *attr,
-			    char *buf)
+static ssize_t pwm1_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm1.pwm));
 }

-static ssize_t set_pwm_reg(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
+static ssize_t pwm1_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -1285,16 +1285,17 @@ static ssize_t set_pwm_reg(struct device
 	return count;
 }

-static ssize_t show_auto_pwm_min(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t temp1_auto_point1_pwm_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1.auto_pwm_min);
 }

-static ssize_t set_auto_pwm_min(struct device *dev,
-				struct device_attribute *attr, const char *buf,
-				size_t count)
+static ssize_t temp1_auto_point1_pwm_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -1316,21 +1317,23 @@ static ssize_t set_auto_pwm_min(struct d
 	return count;
 }

-static ssize_t show_auto_pwm_max(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t temp1_auto_point2_pwm_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	return sprintf(buf, "%d\n", ADM1026_PWM_MAX);
 }

-static ssize_t show_pwm_enable(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t pwm1_enable_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct adm1026_data *data = adm1026_update_device(dev);
 	return sprintf(buf, "%d\n", data->pwm1.enable);
 }

-static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr,
-			      const char *buf, size_t count)
+static ssize_t pwm1_enable_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct adm1026_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -1366,25 +1369,25 @@ static ssize_t set_pwm_enable(struct dev
 }

 /* enable PWM fan control */
-static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm_reg, set_pwm_reg);
-static DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, show_pwm_reg, set_pwm_reg);
-static DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm_reg, set_pwm_reg);
-static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
-	set_pwm_enable);
-static DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
-	set_pwm_enable);
-static DEVICE_ATTR(pwm3_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
-	set_pwm_enable);
-static DEVICE_ATTR(temp1_auto_point1_pwm, S_IRUGO | S_IWUSR,
-	show_auto_pwm_min, set_auto_pwm_min);
+static DEVICE_ATTR_RW(pwm1);
+static DEVICE_ATTR(pwm2, S_IRUGO | S_IWUSR, pwm1_show, pwm1_store);
+static DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, pwm1_show, pwm1_store);
+static DEVICE_ATTR_RW(pwm1_enable);
+static DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR, pwm1_enable_show,
+		   pwm1_enable_store);
+static DEVICE_ATTR(pwm3_enable, S_IRUGO | S_IWUSR, pwm1_enable_show,
+		   pwm1_enable_store);
+static DEVICE_ATTR_RW(temp1_auto_point1_pwm);
 static DEVICE_ATTR(temp2_auto_point1_pwm, S_IRUGO | S_IWUSR,
-	show_auto_pwm_min, set_auto_pwm_min);
+	temp1_auto_point1_pwm_show, temp1_auto_point1_pwm_store);
 static DEVICE_ATTR(temp3_auto_point1_pwm, S_IRUGO | S_IWUSR,
-	show_auto_pwm_min, set_auto_pwm_min);
+	temp1_auto_point1_pwm_show, temp1_auto_point1_pwm_store);

-static DEVICE_ATTR(temp1_auto_point2_pwm, S_IRUGO, show_auto_pwm_max, NULL);
-static DEVICE_ATTR(temp2_auto_point2_pwm, S_IRUGO, show_auto_pwm_max, NULL);
-static DEVICE_ATTR(temp3_auto_point2_pwm, S_IRUGO, show_auto_pwm_max, NULL);
+static DEVICE_ATTR_RO(temp1_auto_point2_pwm);
+static DEVICE_ATTR(temp2_auto_point2_pwm, S_IRUGO, temp1_auto_point2_pwm_show,
+		   NULL);
+static DEVICE_ATTR(temp3_auto_point2_pwm, S_IRUGO, temp1_auto_point2_pwm_show,
+		   NULL);

 static struct attribute *adm1026_attributes[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -561,8 +561,8 @@ static ssize_t store_pwm_auto_point1_pwm
  * The FSC hwmon family has the ability to force an attached alert led to flash
  * from software, we export this as an alert_led sysfs attr
  */
-static ssize_t show_alert_led(struct device *dev,
-	struct device_attribute *devattr, char *buf)
+static ssize_t alert_led_show(struct device *dev,
+		              struct device_attribute *devattr, char *buf)
 {
 	struct fschmd_data *data = fschmd_update_device(dev);

@@ -572,8 +572,9 @@ static ssize_t show_alert_led(struct dev
 		return sprintf(buf, "0\n");
 }

-static ssize_t store_alert_led(struct device *dev,
-	struct device_attribute *devattr, const char *buf, size_t count)
+static ssize_t alert_led_store(struct device *dev,
+			       struct device_attribute *devattr,
+			       const char *buf, size_t count)
 {
 	u8 reg;
 	struct fschmd_data *data = dev_get_drvdata(dev);
@@ -602,7 +603,7 @@ static ssize_t store_alert_led(struct de
 	return count;
 }

-static DEVICE_ATTR(alert_led, 0644, show_alert_led, store_alert_led);
+static DEVICE_ATTR_RW(alert_led);

 static struct sensor_device_attribute fschmd_attr[] = {
 	SENSOR_ATTR(in0_input, 0444, show_in_value, NULL, 0),
diff -u -p a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -400,23 +400,23 @@ show_temp_index(2)
 show_temp_index(3)

 /* VID */
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct smsc47m192_data *data = smsc47m192_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t vrm_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct smsc47m192_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }

-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct smsc47m192_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -431,7 +431,7 @@ static ssize_t set_vrm(struct device *de
 	data->vrm = val;
 	return count;
 }
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+static DEVICE_ATTR_RW(vrm);

 /* Alarms */
 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
diff -u -p a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -450,8 +450,8 @@ static ssize_t set_offset(struct device
 	return count;
 }

-static ssize_t show_interval(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+static ssize_t update_interval_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	int ret = lm95234_update_device(data);
@@ -463,8 +463,9 @@ static ssize_t show_interval(struct devi
 		       DIV_ROUND_CLOSEST(data->interval * 1000, HZ));
 }

-static ssize_t set_interval(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t update_interval_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
 {
 	struct lm95234_data *data = dev_get_drvdata(dev);
 	int ret = lm95234_update_device(data);
@@ -566,8 +567,7 @@ static SENSOR_DEVICE_ATTR(temp4_offset,
 static SENSOR_DEVICE_ATTR(temp5_offset, S_IWUSR | S_IRUGO, show_offset,
 			  set_offset, 3);

-static DEVICE_ATTR(update_interval, S_IWUSR | S_IRUGO, show_interval,
-		   set_interval);
+static DEVICE_ATTR_RW(update_interval);

 static struct attribute *lm95234_common_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -236,22 +236,23 @@ show_in_offset(5);
 show_in_offset(6);

 /* Temperature */
-static ssize_t show_temp(struct device *dev, struct device_attribute *da,
-			 char *buf)
+static ssize_t temp1_input_show(struct device *dev,
+				struct device_attribute *da, char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }

-static ssize_t show_temp_over(struct device *dev, struct device_attribute *da,
+static ssize_t temp1_max_show(struct device *dev, struct device_attribute *da,
 			      char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }

-static ssize_t set_temp_over(struct device *dev, struct device_attribute *da,
-			     const char *buf, size_t count)
+static ssize_t temp1_max_store(struct device *dev,
+			       struct device_attribute *da, const char *buf,
+			       size_t count)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
 	long val;
@@ -268,15 +269,16 @@ static ssize_t set_temp_over(struct devi
 	return count;
 }

-static ssize_t show_temp_hyst(struct device *dev, struct device_attribute *da,
-			      char *buf)
+static ssize_t temp1_max_hyst_show(struct device *dev,
+				   struct device_attribute *da, char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_hyst));
 }

-static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *da,
-			     const char *buf, size_t count)
+static ssize_t temp1_max_hyst_store(struct device *dev,
+				    struct device_attribute *da,
+				    const char *buf, size_t count)
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
 	long val;
@@ -293,11 +295,9 @@ static ssize_t set_temp_hyst(struct devi
 	return count;
 }

-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
-static DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
-		show_temp_over, set_temp_over);
-static DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR,
-		show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR_RO(temp1_input);
+static DEVICE_ATTR_RW(temp1_max);
+static DEVICE_ATTR_RW(temp1_max_hyst);

 /* 3 Fans */
 static ssize_t show_fan(struct device *dev, struct device_attribute *da,
@@ -431,22 +431,22 @@ static SENSOR_DEVICE_ATTR(fan2_div, S_IR
 static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO, show_fan_div, NULL, 2);

 /* VID */
-static ssize_t show_vid(struct device *dev, struct device_attribute *da,
-			char *buf)
+static ssize_t cpu0_vid_show(struct device *dev, struct device_attribute *da,
+			     char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, 82));
 }
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *da,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *da,
 			   char *buf)
 {
 	struct lm78_data *data = lm78_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
 			  char *buf)
diff -u -p a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -575,26 +575,30 @@ static ssize_t show_in_0(struct w83627hf
 	return sprintf(buf,"%ld\n", in0);
 }

-static ssize_t show_regs_in_0(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t in0_input_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in[0]);
 }

-static ssize_t show_regs_in_min0(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t in0_min_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in_min[0]);
 }

-static ssize_t show_regs_in_max0(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t in0_max_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return show_in_0(data, buf, data->in_max[0]);
 }

-static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *attr,
-	const char *buf, size_t count)
+static ssize_t in0_min_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -622,8 +626,9 @@ static ssize_t store_regs_in_min0(struct
 	return count;
 }

-static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *attr,
-	const char *buf, size_t count)
+static ssize_t in0_max_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -651,11 +656,9 @@ static ssize_t store_regs_in_max0(struct
 	return count;
 }

-static DEVICE_ATTR(in0_input, S_IRUGO, show_regs_in_0, NULL);
-static DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
-	show_regs_in_min0, store_regs_in_min0);
-static DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
-	show_regs_in_max0, store_regs_in_max0);
+static DEVICE_ATTR_RO(in0_input);
+static DEVICE_ATTR_RW(in0_min);
+static DEVICE_ATTR_RW(in0_max);

 static ssize_t
 show_fan_input(struct device *dev, struct device_attribute *devattr, char *buf)
@@ -796,21 +799,22 @@ sysfs_temp_decl(2);
 sysfs_temp_decl(3);

 static ssize_t
-show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
+cpu0_vid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

 static ssize_t
-show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
+vrm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }
 static ssize_t
-store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+vrm_store(struct device *dev, struct device_attribute *attr, const char *buf,
+	  size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -826,15 +830,15 @@ store_vrm_reg(struct device *dev, struct

 	return count;
 }
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
+static DEVICE_ATTR_RW(vrm);

 static ssize_t
-show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
+alarms_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) data->alarms);
 }
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t
 show_alarm(struct device *dev, struct device_attribute *attr, char *buf)
@@ -860,7 +864,7 @@ static SENSOR_DEVICE_ATTR(temp2_alarm, S
 static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13);

 static ssize_t
-show_beep_mask(struct device *dev, struct device_attribute *attr, char *buf)
+beep_mask_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627hf_data *data = w83627hf_update_device(dev);
 	return sprintf(buf, "%ld\n",
@@ -868,7 +872,7 @@ show_beep_mask(struct device *dev, struc
 }

 static ssize_t
-store_beep_mask(struct device *dev, struct device_attribute *attr,
+beep_mask_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);
@@ -895,8 +899,7 @@ store_beep_mask(struct device *dev, stru
 	return count;
 }

-static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR,
-		   show_beep_mask, store_beep_mask);
+static DEVICE_ATTR_RW(beep_mask);

 static ssize_t
 show_beep(struct device *dev, struct device_attribute *attr, char *buf)
@@ -1264,13 +1267,13 @@ sysfs_temp_type(2);
 sysfs_temp_type(3);

 static ssize_t
-show_name(struct device *dev, struct device_attribute *devattr, char *buf)
+name_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct w83627hf_data *data = dev_get_drvdata(dev);

 	return sprintf(buf, "%s\n", data->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static int __init w83627hf_find(int sioaddr, unsigned short *addr,
 				struct w83627hf_sio_data *sio_data)
diff -u -p a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -270,8 +270,8 @@ static ssize_t get_fan(struct device *de
  * controlled.
  */

-static ssize_t get_target(struct device *dev, struct device_attribute *devattr,
-			 char *buf)
+static ssize_t fan1_target_show(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
 	struct max6650_data *data = max6650_update_device(dev);
 	int kscale, ktach, rpm;
@@ -318,8 +318,9 @@ static int max6650_set_target(struct max
 					 data->speed);
 }

-static ssize_t set_target(struct device *dev, struct device_attribute *devattr,
-			 const char *buf, size_t count)
+static ssize_t fan1_target_store(struct device *dev,
+				 struct device_attribute *devattr,
+				 const char *buf, size_t count)
 {
 	struct max6650_data *data = dev_get_drvdata(dev);
 	unsigned long rpm;
@@ -350,8 +351,8 @@ static ssize_t set_target(struct device
  * back exactly the value you have set.
  */

-static ssize_t get_pwm(struct device *dev, struct device_attribute *devattr,
-		       char *buf)
+static ssize_t pwm1_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	int pwm;
 	struct max6650_data *data = max6650_update_device(dev);
@@ -371,8 +372,9 @@ static ssize_t get_pwm(struct device *de
 	return sprintf(buf, "%d\n", pwm);
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *devattr,
-			const char *buf, size_t count)
+static ssize_t pwm1_store(struct device *dev,
+			  struct device_attribute *devattr, const char *buf,
+			  size_t count)
 {
 	struct max6650_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -406,8 +408,8 @@ static ssize_t set_pwm(struct device *de
  * 2 = Closed loop, RPM for all fans regulated by fan1 tachometer
  * 3 = Fan off
  */
-static ssize_t get_enable(struct device *dev, struct device_attribute *devattr,
-			  char *buf)
+static ssize_t pwm1_enable_show(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
 	struct max6650_data *data = max6650_update_device(dev);
 	int mode = (data->config & MAX6650_CFG_MODE_MASK) >> 4;
@@ -416,8 +418,9 @@ static ssize_t get_enable(struct device
 	return sprintf(buf, "%d\n", sysfs_modes[mode]);
 }

-static ssize_t set_enable(struct device *dev, struct device_attribute *devattr,
-			  const char *buf, size_t count)
+static ssize_t pwm1_enable_store(struct device *dev,
+				 struct device_attribute *devattr,
+				 const char *buf, size_t count)
 {
 	struct max6650_data *data = dev_get_drvdata(dev);
 	unsigned long mode;
@@ -458,16 +461,17 @@ static ssize_t set_enable(struct device
  * defined for that. See the data sheet for details.
  */

-static ssize_t get_div(struct device *dev, struct device_attribute *devattr,
-		       char *buf)
+static ssize_t fan1_div_show(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
 {
 	struct max6650_data *data = max6650_update_device(dev);

 	return sprintf(buf, "%d\n", DIV_FROM_REG(data->count));
 }

-static ssize_t set_div(struct device *dev, struct device_attribute *devattr,
-		       const char *buf, size_t count)
+static ssize_t fan1_div_store(struct device *dev,
+			      struct device_attribute *devattr,
+			      const char *buf, size_t count)
 {
 	struct max6650_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -534,10 +538,10 @@ static SENSOR_DEVICE_ATTR(fan1_input, S_
 static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, get_fan, NULL, 1);
 static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, get_fan, NULL, 2);
 static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, get_fan, NULL, 3);
-static DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO, get_target, set_target);
-static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, get_div, set_div);
-static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, get_enable, set_enable);
-static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
+static DEVICE_ATTR_RW(fan1_target);
+static DEVICE_ATTR_RW(fan1_div);
+static DEVICE_ATTR_RW(pwm1_enable);
+static DEVICE_ATTR_RW(pwm1);
 static SENSOR_DEVICE_ATTR(fan1_max_alarm, S_IRUGO, get_alarm, NULL,
 			  MAX6650_ALRM_MAX);
 static SENSOR_DEVICE_ATTR(fan1_min_alarm, S_IRUGO, get_alarm, NULL,
diff -u -p a/drivers/hwmon/pcf8591.c b/drivers/hwmon/pcf8591.c
--- a/drivers/hwmon/pcf8591.c
+++ b/drivers/hwmon/pcf8591.c
@@ -103,16 +103,16 @@ show_in_channel(1);
 show_in_channel(2);
 show_in_channel(3);

-static ssize_t show_out0_ouput(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t out0_output_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%d\n", data->aout * 10);
 }

-static ssize_t set_out0_output(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t out0_output_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	unsigned long val;
 	struct i2c_client *client = to_i2c_client(dev);
@@ -132,19 +132,18 @@ static ssize_t set_out0_output(struct de
 	return count;
 }

-static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO,
-		   show_out0_ouput, set_out0_output);
+static DEVICE_ATTR_RW(out0_output);

-static ssize_t show_out0_enable(struct device *dev,
+static ssize_t out0_enable_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
 	return sprintf(buf, "%u\n", !(!(data->control & PCF8591_CONTROL_AOEF)));
 }

-static ssize_t set_out0_enable(struct device *dev,
-			       struct device_attribute *attr,
-			       const char *buf, size_t count)
+static ssize_t out0_enable_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct pcf8591_data *data = i2c_get_clientdata(client);
@@ -165,8 +164,7 @@ static ssize_t set_out0_enable(struct de
 	return count;
 }

-static DEVICE_ATTR(out0_enable, S_IWUSR | S_IRUGO,
-		   show_out0_enable, set_out0_enable);
+static DEVICE_ATTR_RW(out0_enable);

 static struct attribute *pcf8591_attributes[] = {
 	&dev_attr_out0_enable.attr,
diff -u -p a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -40,8 +40,8 @@ struct mc13783_adc_priv {
 	char name[PLATFORM_NAME_SIZE];
 };

-static ssize_t mc13783_adc_show_name(struct device *dev, struct device_attribute
-			      *devattr, char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct mc13783_adc_priv *priv = dev_get_drvdata(dev);

@@ -111,7 +111,7 @@ static ssize_t mc13783_adc_read_gp(struc
 	return sprintf(buf, "%u\n", val);
 }

-static DEVICE_ATTR(name, S_IRUGO, mc13783_adc_show_name, NULL);
+static DEVICE_ATTR_RO(name);
 static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, mc13783_adc_read_bp, NULL, 2);
 static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, mc13783_adc_read_gp, NULL, 5);
 static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, mc13783_adc_read_gp, NULL, 6);
diff -u -p a/drivers/hwmon/vt8231.c b/drivers/hwmon/vt8231.c
--- a/drivers/hwmon/vt8231.c
+++ b/drivers/hwmon/vt8231.c
@@ -263,8 +263,8 @@ static ssize_t set_in_max(struct device
 }

 /* Special case for input 5 as this has 3.3V scaling built into the chip */
-static ssize_t show_in5(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t in5_input_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct vt8231_data *data = vt8231_update_device(dev);

@@ -272,8 +272,8 @@ static ssize_t show_in5(struct device *d
 		(((data->in[5] - 3) * 10000 * 54) / (958 * 34)));
 }

-static ssize_t show_in5_min(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t in5_min_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct vt8231_data *data = vt8231_update_device(dev);

@@ -281,8 +281,8 @@ static ssize_t show_in5_min(struct devic
 		(((data->in_min[5] - 3) * 10000 * 54) / (958 * 34)));
 }

-static ssize_t show_in5_max(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t in5_max_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
 {
 	struct vt8231_data *data = vt8231_update_device(dev);

@@ -290,8 +290,9 @@ static ssize_t show_in5_max(struct devic
 		(((data->in_max[5] - 3) * 10000 * 54) / (958 * 34)));
 }

-static ssize_t set_in5_min(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t in5_min_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct vt8231_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -309,8 +310,9 @@ static ssize_t set_in5_min(struct device
 	return count;
 }

-static ssize_t set_in5_max(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t in5_max_store(struct device *dev,
+			     struct device_attribute *attr, const char *buf,
+			     size_t count)
 {
 	struct vt8231_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -342,34 +344,35 @@ define_voltage_sysfs(2);
 define_voltage_sysfs(3);
 define_voltage_sysfs(4);

-static DEVICE_ATTR(in5_input, S_IRUGO, show_in5, NULL);
-static DEVICE_ATTR(in5_min, S_IRUGO | S_IWUSR, show_in5_min, set_in5_min);
-static DEVICE_ATTR(in5_max, S_IRUGO | S_IWUSR, show_in5_max, set_in5_max);
+static DEVICE_ATTR_RO(in5_input);
+static DEVICE_ATTR_RW(in5_min);
+static DEVICE_ATTR_RW(in5_max);

 /* Temperatures */
-static ssize_t show_temp0(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t temp1_input_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct vt8231_data *data = vt8231_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp[0] * 250);
 }

-static ssize_t show_temp0_max(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t temp1_max_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct vt8231_data *data = vt8231_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp_max[0] * 1000);
 }

-static ssize_t show_temp0_min(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t temp1_max_hyst_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct vt8231_data *data = vt8231_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp_min[0] * 1000);
 }

-static ssize_t set_temp0_max(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t temp1_max_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
 {
 	struct vt8231_data *data = dev_get_drvdata(dev);
 	long val;
@@ -385,8 +388,9 @@ static ssize_t set_temp0_max(struct devi
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static ssize_t set_temp0_min(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t temp1_max_hyst_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
 {
 	struct vt8231_data *data = dev_get_drvdata(dev);
 	long val;
@@ -481,10 +485,9 @@ static SENSOR_DEVICE_ATTR(temp##offset##
 static SENSOR_DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO | S_IWUSR,	\
 		show_temp_min, set_temp_min, offset - 1)

-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp0, NULL);
-static DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp0_max, set_temp0_max);
-static DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR, show_temp0_min,
-		   set_temp0_min);
+static DEVICE_ATTR_RO(temp1_input);
+static DEVICE_ATTR_RW(temp1_max);
+static DEVICE_ATTR_RW(temp1_max_hyst);

 define_temperature_sysfs(2);
 define_temperature_sysfs(3);
@@ -603,13 +606,13 @@ define_fan_sysfs(1);
 define_fan_sysfs(2);

 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct vt8231_data *data = vt8231_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -633,13 +636,13 @@ static SENSOR_DEVICE_ATTR(in5_alarm, S_I
 static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
 static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);

-static ssize_t show_name(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct vt8231_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%s\n", data->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static struct attribute *vt8231_attributes_temps[6][5] = {
 	{
diff -u -p a/drivers/hwmon/g760a.c b/drivers/hwmon/g760a.c
--- a/drivers/hwmon/g760a.c
+++ b/drivers/hwmon/g760a.c
@@ -107,8 +107,8 @@ static struct g760a_data *g760a_update_c
 	return data;
 }

-static ssize_t show_fan(struct device *dev, struct device_attribute *da,
-			char *buf)
+static ssize_t fan1_input_show(struct device *dev,
+			       struct device_attribute *da, char *buf)
 {
 	struct g760a_data *data = g760a_update_client(dev);
 	unsigned int rpm = 0;
@@ -121,8 +121,8 @@ static ssize_t show_fan(struct device *d
 	return sprintf(buf, "%d\n", rpm);
 }

-static ssize_t show_fan_alarm(struct device *dev, struct device_attribute *da,
-			      char *buf)
+static ssize_t fan1_alarm_show(struct device *dev,
+			       struct device_attribute *da, char *buf)
 {
 	struct g760a_data *data = g760a_update_client(dev);

@@ -131,16 +131,16 @@ static ssize_t show_fan_alarm(struct dev
 	return sprintf(buf, "%d\n", fan_alarm);
 }

-static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
-		       char *buf)
+static ssize_t pwm1_show(struct device *dev, struct device_attribute *da,
+			 char *buf)
 {
 	struct g760a_data *data = g760a_update_client(dev);

 	return sprintf(buf, "%d\n", PWM_FROM_CNT(data->set_cnt));
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
-		       const char *buf, size_t count)
+static ssize_t pwm1_store(struct device *dev, struct device_attribute *da,
+			  const char *buf, size_t count)
 {
 	struct g760a_data *data = g760a_update_client(dev);
 	struct i2c_client *client = data->client;
@@ -157,9 +157,9 @@ static ssize_t set_pwm(struct device *de
 	return count;
 }

-static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
-static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL);
-static DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL);
+static DEVICE_ATTR_RW(pwm1);
+static DEVICE_ATTR_RO(fan1_input);
+static DEVICE_ATTR_RO(fan1_alarm);

 static struct attribute *g760a_attrs[] = {
 	&dev_attr_pwm1.attr,
diff -u -p a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -44,8 +44,8 @@ static irqreturn_t jz4740_hwmon_irq(int
 	return IRQ_HANDLED;
 }

-static ssize_t jz4740_hwmon_read_adcin(struct device *dev,
-	struct device_attribute *dev_attr, char *buf)
+static ssize_t in0_input_show(struct device *dev,
+			      struct device_attribute *dev_attr, char *buf)
 {
 	struct jz4740_hwmon *hwmon = dev_get_drvdata(dev);
 	struct platform_device *pdev = hwmon->pdev;
@@ -79,7 +79,7 @@ static ssize_t jz4740_hwmon_read_adcin(s
 	return ret;
 }

-static DEVICE_ATTR(in0_input, S_IRUGO, jz4740_hwmon_read_adcin, NULL);
+static DEVICE_ATTR_RO(in0_input);

 static struct attribute *jz4740_attrs[] = {
 	&dev_attr_in0_input.attr,
diff -u -p a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -83,8 +83,8 @@ static bool is_carrizo_or_later(void)
 	return boot_cpu_data.x86 == 0x15 && boot_cpu_data.x86_model >= 0x60;
 }

-static ssize_t show_power(struct device *dev,
-			  struct device_attribute *attr, char *buf)
+static ssize_t power1_input_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
 {
 	u32 val, tdp_limit, running_avg_range;
 	s32 running_avg_capture;
@@ -136,16 +136,16 @@ static ssize_t show_power(struct device
 	curr_pwr_watts = (curr_pwr_watts * 15625) >> (10 + running_avg_range);
 	return sprintf(buf, "%u\n", (unsigned int) curr_pwr_watts);
 }
-static DEVICE_ATTR(power1_input, S_IRUGO, show_power, NULL);
+static DEVICE_ATTR_RO(power1_input);

-static ssize_t show_power_crit(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t power1_crit_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct fam15h_power_data *data = dev_get_drvdata(dev);

 	return sprintf(buf, "%u\n", data->processor_pwr_watts);
 }
-static DEVICE_ATTR(power1_crit, S_IRUGO, show_power_crit, NULL);
+static DEVICE_ATTR_RO(power1_crit);

 static void do_read_registers_on_cu(void *_data)
 {
@@ -212,9 +212,8 @@ static int read_registers(struct fam15h_
 	return 0;
 }

-static ssize_t acc_show_power(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
+static ssize_t power1_average_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct fam15h_power_data *data = dev_get_drvdata(dev);
 	u64 prev_cu_acc_power[MAX_CUS], prev_ptsc[MAX_CUS],
@@ -267,20 +266,20 @@ static ssize_t acc_show_power(struct dev

 	return sprintf(buf, "%llu\n", (unsigned long long)avg_acc);
 }
-static DEVICE_ATTR(power1_average, S_IRUGO, acc_show_power, NULL);
+static DEVICE_ATTR_RO(power1_average);

-static ssize_t acc_show_power_period(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
+static ssize_t power1_average_interval_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	struct fam15h_power_data *data = dev_get_drvdata(dev);

 	return sprintf(buf, "%lu\n", data->power_period);
 }

-static ssize_t acc_set_power_period(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t count)
+static ssize_t power1_average_interval_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
 {
 	struct fam15h_power_data *data = dev_get_drvdata(dev);
 	unsigned long temp;
@@ -301,8 +300,7 @@ static ssize_t acc_set_power_period(stru

 	return count;
 }
-static DEVICE_ATTR(power1_average_interval, S_IRUGO | S_IWUSR,
-		   acc_show_power_period, acc_set_power_period);
+static DEVICE_ATTR_RW(power1_average_interval);

 static int fam15h_power_init_attrs(struct pci_dev *pdev,
 				   struct fam15h_power_data *data)
diff -u -p a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -417,16 +417,16 @@ static ssize_t set_pwm1(struct device *d
 	return count;
 }

-static ssize_t show_pwm1_enable(struct device *dev,
+static ssize_t pwm1_enable_show(struct device *dev,
 				struct device_attribute *dummy, char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
 	return sprintf(buf, "%d\n", data->config_fan & 0x20 ? 1 : 2);
 }

-static ssize_t set_pwm1_enable(struct device *dev,
-			       struct device_attribute *dummy,
-			       const char *buf, size_t count)
+static ssize_t pwm1_enable_store(struct device *dev,
+				 struct device_attribute *dummy,
+				 const char *buf, size_t count)
 {
 	struct lm63_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -600,7 +600,7 @@ static ssize_t set_temp11(struct device
  * Hysteresis register holds a relative value, while we want to present
  * an absolute to user-space
  */
-static ssize_t show_temp2_crit_hyst(struct device *dev,
+static ssize_t temp2_crit_hyst_show(struct device *dev,
 				    struct device_attribute *dummy, char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
@@ -624,9 +624,9 @@ static ssize_t show_lut_temp_hyst(struct
  * And now the other way around, user-space provides an absolute
  * hysteresis value and we have to store a relative one
  */
-static ssize_t set_temp2_crit_hyst(struct device *dev,
-				   struct device_attribute *dummy,
-				   const char *buf, size_t count)
+static ssize_t temp2_crit_hyst_store(struct device *dev,
+				     struct device_attribute *dummy,
+				     const char *buf, size_t count)
 {
 	struct lm63_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -670,7 +670,7 @@ static void lm63_set_convrate(struct lm6
 	data->update_interval = UPDATE_INTERVAL(data->max_convrate_hz, i);
 }

-static ssize_t show_update_interval(struct device *dev,
+static ssize_t update_interval_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct lm63_data *data = dev_get_drvdata(dev);
@@ -678,9 +678,9 @@ static ssize_t show_update_interval(stru
 	return sprintf(buf, "%u\n", data->update_interval);
 }

-static ssize_t set_update_interval(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
+static ssize_t update_interval_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
 {
 	struct lm63_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -697,16 +697,17 @@ static ssize_t set_update_interval(struc
 	return count;
 }

-static ssize_t show_type(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static ssize_t temp2_type_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct lm63_data *data = dev_get_drvdata(dev);

 	return sprintf(buf, data->trutherm ? "1\n" : "2\n");
 }

-static ssize_t set_type(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+static ssize_t temp2_type_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
 {
 	struct lm63_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -731,7 +732,7 @@ static ssize_t set_type(struct device *d
 	return count;
 }

-static ssize_t show_alarms(struct device *dev, struct device_attribute *dummy,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *dummy,
 			   char *buf)
 {
 	struct lm63_data *data = lm63_update_device(dev);
@@ -753,8 +754,7 @@ static SENSOR_DEVICE_ATTR(fan1_min, S_IW
 	set_fan, 1);

 static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm1, set_pwm1, 0);
-static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
-	show_pwm1_enable, set_pwm1_enable);
+static DEVICE_ATTR_RW(pwm1_enable);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point1_pwm, S_IWUSR | S_IRUGO,
 	show_pwm1, set_pwm1, 1);
 static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IWUSR | S_IRUGO,
@@ -841,10 +841,9 @@ static SENSOR_DEVICE_ATTR(temp2_offset,
 	set_temp11, 3);
 static SENSOR_DEVICE_ATTR(temp2_crit, S_IRUGO, show_remote_temp8,
 	set_temp8, 2);
-static DEVICE_ATTR(temp2_crit_hyst, S_IWUSR | S_IRUGO, show_temp2_crit_hyst,
-	set_temp2_crit_hyst);
+static DEVICE_ATTR_RW(temp2_crit_hyst);

-static DEVICE_ATTR(temp2_type, S_IWUSR | S_IRUGO, show_type, set_type);
+static DEVICE_ATTR_RW(temp2_type);

 /* Individual alarm files */
 static SENSOR_DEVICE_ATTR(fan1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
@@ -854,10 +853,9 @@ static SENSOR_DEVICE_ATTR(temp2_min_alar
 static SENSOR_DEVICE_ATTR(temp2_max_alarm, S_IRUGO, show_alarm, NULL, 4);
 static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 6);
 /* Raw alarm file for compatibility */
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

-static DEVICE_ATTR(update_interval, S_IRUGO | S_IWUSR, show_update_interval,
-		   set_update_interval);
+static DEVICE_ATTR_RW(update_interval);

 static struct attribute *lm63_attributes[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
diff -u -p a/drivers/hwmon/emc2103.c b/drivers/hwmon/emc2103.c
--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -284,7 +284,7 @@ static ssize_t set_temp_max(struct devic
 }

 static ssize_t
-show_fan(struct device *dev, struct device_attribute *da, char *buf)
+fan1_input_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct emc2103_data *data = emc2103_update_device(dev);
 	int rpm = 0;
@@ -294,7 +294,7 @@ show_fan(struct device *dev, struct devi
 }

 static ssize_t
-show_fan_div(struct device *dev, struct device_attribute *da, char *buf)
+fan1_div_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct emc2103_data *data = emc2103_update_device(dev);
 	int fan_div = 8 / data->fan_multiplier;
@@ -307,8 +307,8 @@ show_fan_div(struct device *dev, struct
  * of least surprise; the user doesn't expect the fan target to change just
  * because the divider changed.
  */
-static ssize_t set_fan_div(struct device *dev, struct device_attribute *da,
-			   const char *buf, size_t count)
+static ssize_t fan1_div_store(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
 {
 	struct emc2103_data *data = emc2103_update_device(dev);
 	struct i2c_client *client = data->client;
@@ -369,7 +369,7 @@ static ssize_t set_fan_div(struct device
 }

 static ssize_t
-show_fan_target(struct device *dev, struct device_attribute *da, char *buf)
+fan1_target_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct emc2103_data *data = emc2103_update_device(dev);
 	int rpm = 0;
@@ -382,8 +382,9 @@ show_fan_target(struct device *dev, stru
 	return sprintf(buf, "%d\n", rpm);
 }

-static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
-			      const char *buf, size_t count)
+static ssize_t fan1_target_store(struct device *dev,
+				 struct device_attribute *da, const char *buf,
+				 size_t count)
 {
 	struct emc2103_data *data = emc2103_update_device(dev);
 	struct i2c_client *client = data->client;
@@ -412,7 +413,7 @@ static ssize_t set_fan_target(struct dev
 }

 static ssize_t
-show_fan_fault(struct device *dev, struct device_attribute *da, char *buf)
+fan1_fault_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct emc2103_data *data = emc2103_update_device(dev);
 	bool fault = ((data->fan_tach & 0x1fe0) == 0x1fe0);
@@ -420,14 +421,15 @@ show_fan_fault(struct device *dev, struc
 }

 static ssize_t
-show_pwm_enable(struct device *dev, struct device_attribute *da, char *buf)
+pwm1_enable_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct emc2103_data *data = emc2103_update_device(dev);
 	return sprintf(buf, "%d\n", data->fan_rpm_control ? 3 : 0);
 }

-static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *da,
-			      const char *buf, size_t count)
+static ssize_t pwm1_enable_store(struct device *dev,
+				 struct device_attribute *da, const char *buf,
+				 size_t count)
 {
 	struct emc2103_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -512,14 +514,12 @@ static SENSOR_DEVICE_ATTR(temp4_min_alar
 static SENSOR_DEVICE_ATTR(temp4_max_alarm, S_IRUGO, show_temp_max_alarm,
 	NULL, 3);

-static DEVICE_ATTR(fan1_input, S_IRUGO, show_fan, NULL);
-static DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR, show_fan_div, set_fan_div);
-static DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR, show_fan_target,
-	set_fan_target);
-static DEVICE_ATTR(fan1_fault, S_IRUGO, show_fan_fault, NULL);
+static DEVICE_ATTR_RO(fan1_input);
+static DEVICE_ATTR_RW(fan1_div);
+static DEVICE_ATTR_RW(fan1_target);
+static DEVICE_ATTR_RO(fan1_fault);

-static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
-	set_pwm_enable);
+static DEVICE_ATTR_RW(pwm1_enable);

 /* sensors present on all models */
 static struct attribute *emc2103_attributes[] = {
diff -u -p a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
--- a/drivers/hwmon/g762.c
+++ b/drivers/hwmon/g762.c
@@ -738,8 +738,8 @@ static int g762_pdata_prop_import(struct
  * Read function for fan1_input sysfs file. Return current fan RPM value, or
  * 0 if fan is out of control.
  */
-static ssize_t get_fan_rpm(struct device *dev, struct device_attribute *da,
-			   char *buf)
+static ssize_t fan1_input_show(struct device *dev,
+			       struct device_attribute *da, char *buf)
 {
 	struct g762_data *data = g762_update_client(dev);
 	unsigned int rpm = 0;
@@ -764,8 +764,8 @@ static ssize_t get_fan_rpm(struct device
  * Read and write functions for pwm1_mode sysfs file. Get and set fan speed
  * control mode i.e. PWM (1) or DC (0).
  */
-static ssize_t get_pwm_mode(struct device *dev, struct device_attribute *da,
-			    char *buf)
+static ssize_t pwm1_mode_show(struct device *dev, struct device_attribute *da,
+			      char *buf)
 {
 	struct g762_data *data = g762_update_client(dev);

@@ -776,8 +776,9 @@ static ssize_t get_pwm_mode(struct devic
 		       !!(data->fan_cmd1 & G762_REG_FAN_CMD1_OUT_MODE));
 }

-static ssize_t set_pwm_mode(struct device *dev, struct device_attribute *da,
-			    const char *buf, size_t count)
+static ssize_t pwm1_mode_store(struct device *dev,
+			       struct device_attribute *da, const char *buf,
+			       size_t count)
 {
 	unsigned long val;
 	int ret;
@@ -796,8 +797,8 @@ static ssize_t set_pwm_mode(struct devic
  * Read and write functions for fan1_div sysfs file. Get and set fan
  * controller prescaler value
  */
-static ssize_t get_fan_div(struct device *dev,
-			   struct device_attribute *da, char *buf)
+static ssize_t fan1_div_show(struct device *dev, struct device_attribute *da,
+			     char *buf)
 {
 	struct g762_data *data = g762_update_client(dev);

@@ -807,9 +808,8 @@ static ssize_t get_fan_div(struct device
 	return sprintf(buf, "%d\n", G762_CLKDIV_FROM_REG(data->fan_cmd1));
 }

-static ssize_t set_fan_div(struct device *dev,
-			   struct device_attribute *da,
-			   const char *buf, size_t count)
+static ssize_t fan1_div_store(struct device *dev, struct device_attribute *da,
+			      const char *buf, size_t count)
 {
 	unsigned long val;
 	int ret;
@@ -828,8 +828,8 @@ static ssize_t set_fan_div(struct device
  * Read and write functions for fan1_pulses sysfs file. Get and set number
  * of tachometer pulses per fan revolution.
  */
-static ssize_t get_fan_pulses(struct device *dev,
-			      struct device_attribute *da, char *buf)
+static ssize_t fan1_pulses_show(struct device *dev,
+				struct device_attribute *da, char *buf)
 {
 	struct g762_data *data = g762_update_client(dev);

@@ -839,9 +839,9 @@ static ssize_t get_fan_pulses(struct dev
 	return sprintf(buf, "%d\n", G762_PULSE_FROM_REG(data->fan_cmd1));
 }

-static ssize_t set_fan_pulses(struct device *dev,
-			      struct device_attribute *da,
-			      const char *buf, size_t count)
+static ssize_t fan1_pulses_store(struct device *dev,
+				 struct device_attribute *da, const char *buf,
+				 size_t count)
 {
 	unsigned long val;
 	int ret;
@@ -870,8 +870,8 @@ static ssize_t set_fan_pulses(struct dev
  * but we do not accept 0 as this mode is not natively supported by the chip
  * and it is not emulated by g762 driver. -EINVAL is returned in this case.
  */
-static ssize_t get_pwm_enable(struct device *dev,
-			      struct device_attribute *da, char *buf)
+static ssize_t pwm1_enable_show(struct device *dev,
+				struct device_attribute *da, char *buf)
 {
 	struct g762_data *data = g762_update_client(dev);

@@ -882,9 +882,9 @@ static ssize_t get_pwm_enable(struct dev
 		       (!!(data->fan_cmd1 & G762_REG_FAN_CMD1_FAN_MODE)) + 1);
 }

-static ssize_t set_pwm_enable(struct device *dev,
-			      struct device_attribute *da,
-			      const char *buf, size_t count)
+static ssize_t pwm1_enable_store(struct device *dev,
+				 struct device_attribute *da, const char *buf,
+				 size_t count)
 {
 	unsigned long val;
 	int ret;
@@ -904,8 +904,8 @@ static ssize_t set_pwm_enable(struct dev
  * (which affects fan speed) in open-loop mode. 0 stops the fan and 255
  * makes it run at full speed.
  */
-static ssize_t get_pwm(struct device *dev, struct device_attribute *da,
-		       char *buf)
+static ssize_t pwm1_show(struct device *dev, struct device_attribute *da,
+			 char *buf)
 {
 	struct g762_data *data = g762_update_client(dev);

@@ -915,8 +915,8 @@ static ssize_t get_pwm(struct device *de
 	return sprintf(buf, "%d\n", data->set_out);
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
-		       const char *buf, size_t count)
+static ssize_t pwm1_store(struct device *dev, struct device_attribute *da,
+			  const char *buf, size_t count)
 {
 	unsigned long val;
 	int ret;
@@ -942,8 +942,8 @@ static ssize_t set_pwm(struct device *de
  * Also note that due to rounding errors it is possible that you don't read
  * back exactly the value you have set.
  */
-static ssize_t get_fan_target(struct device *dev, struct device_attribute *da,
-			      char *buf)
+static ssize_t fan1_target_show(struct device *dev,
+				struct device_attribute *da, char *buf)
 {
 	struct g762_data *data = g762_update_client(dev);
 	unsigned int rpm;
@@ -961,8 +961,9 @@ static ssize_t get_fan_target(struct dev
 	return sprintf(buf, "%u\n", rpm);
 }

-static ssize_t set_fan_target(struct device *dev, struct device_attribute *da,
-			      const char *buf, size_t count)
+static ssize_t fan1_target_store(struct device *dev,
+				 struct device_attribute *da, const char *buf,
+				 size_t count)
 {
 	unsigned long val;
 	int ret;
@@ -978,8 +979,8 @@ static ssize_t set_fan_target(struct dev
 }

 /* read function for fan1_fault sysfs file. */
-static ssize_t get_fan_failure(struct device *dev, struct device_attribute *da,
-			       char *buf)
+static ssize_t fan1_fault_show(struct device *dev,
+			       struct device_attribute *da, char *buf)
 {
 	struct g762_data *data = g762_update_client(dev);

@@ -993,8 +994,8 @@ static ssize_t get_fan_failure(struct de
  * read function for fan1_alarm sysfs file. Note that OOC condition is
  * enabled low
  */
-static ssize_t get_fan_ooc(struct device *dev, struct device_attribute *da,
-			   char *buf)
+static ssize_t fan1_alarm_show(struct device *dev,
+			       struct device_attribute *da, char *buf)
 {
 	struct g762_data *data = g762_update_client(dev);

@@ -1004,18 +1005,15 @@ static ssize_t get_fan_ooc(struct device
 	return sprintf(buf, "%u\n", !(data->fan_sta & G762_REG_FAN_STA_OOC));
 }

-static DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, get_pwm, set_pwm);
-static DEVICE_ATTR(pwm1_mode, S_IWUSR | S_IRUGO, get_pwm_mode, set_pwm_mode);
-static DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
-		   get_pwm_enable, set_pwm_enable);
-static DEVICE_ATTR(fan1_input, S_IRUGO, get_fan_rpm, NULL);
-static DEVICE_ATTR(fan1_alarm, S_IRUGO, get_fan_ooc, NULL);
-static DEVICE_ATTR(fan1_fault, S_IRUGO, get_fan_failure, NULL);
-static DEVICE_ATTR(fan1_target, S_IWUSR | S_IRUGO,
-		   get_fan_target, set_fan_target);
-static DEVICE_ATTR(fan1_div, S_IWUSR | S_IRUGO, get_fan_div, set_fan_div);
-static DEVICE_ATTR(fan1_pulses, S_IWUSR | S_IRUGO,
-		   get_fan_pulses, set_fan_pulses);
+static DEVICE_ATTR_RW(pwm1);
+static DEVICE_ATTR_RW(pwm1_mode);
+static DEVICE_ATTR_RW(pwm1_enable);
+static DEVICE_ATTR_RO(fan1_input);
+static DEVICE_ATTR_RO(fan1_alarm);
+static DEVICE_ATTR_RO(fan1_fault);
+static DEVICE_ATTR_RW(fan1_target);
+static DEVICE_ATTR_RW(fan1_div);
+static DEVICE_ATTR_RW(fan1_pulses);

 /* Driver data */
 static struct attribute *g762_attrs[] = {
diff -u -p a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -416,24 +416,24 @@ sysfs_temp_offsets(2);
 sysfs_temp_offsets(3);

 static ssize_t
-show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
+cpu0_vid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
 }

-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

 static ssize_t
-show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
+vrm_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }

 static ssize_t
-store_vrm_reg(struct device *dev, struct device_attribute *attr,
-	      const char *buf, size_t count)
+vrm_store(struct device *dev, struct device_attribute *attr, const char *buf,
+	  size_t count)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -447,16 +447,16 @@ store_vrm_reg(struct device *dev, struct
 	return count;
 }

-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
+static DEVICE_ATTR_RW(vrm);

 static ssize_t
-show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
+alarms_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -491,8 +491,8 @@ static SENSOR_DEVICE_ATTR(temp1_alarm, S
 static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5);
 static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_temp3_alarm, NULL, 0);

-static ssize_t show_beep_mask(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t beep_mask_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%ld\n",
@@ -500,7 +500,7 @@ static ssize_t show_beep_mask(struct dev
 }

 static ssize_t
-store_beep_mask(struct device *dev, struct device_attribute *attr,
+beep_mask_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
@@ -527,8 +527,7 @@ store_beep_mask(struct device *dev, stru
 	return count;
 }

-static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR,
-		show_beep_mask, store_beep_mask);
+static DEVICE_ATTR_RW(beep_mask);

 static ssize_t show_beep(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -708,7 +707,7 @@ show_pwm(struct device *dev, struct devi
 }

 static ssize_t
-show_pwm2_enable(struct device *dev, struct device_attribute *da, char *buf)
+pwm2_enable_show(struct device *dev, struct device_attribute *da, char *buf)
 {
 	struct w83781d_data *data = w83781d_update_device(dev);
 	return sprintf(buf, "%d\n", (int)data->pwm2_enable);
@@ -736,8 +735,8 @@ store_pwm(struct device *dev, struct dev
 }

 static ssize_t
-store_pwm2_enable(struct device *dev, struct device_attribute *da,
-		const char *buf, size_t count)
+pwm2_enable_store(struct device *dev, struct device_attribute *da,
+		  const char *buf, size_t count)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -778,8 +777,7 @@ static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO
 static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 2);
 static SENSOR_DEVICE_ATTR(pwm4, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 3);
 /* only PWM2 can be enabled/disabled */
-static DEVICE_ATTR(pwm2_enable, S_IRUGO | S_IWUSR,
-		show_pwm2_enable, store_pwm2_enable);
+static DEVICE_ATTR_RW(pwm2_enable);

 static ssize_t
 show_sensor(struct device *dev, struct device_attribute *da, char *buf)
@@ -1616,12 +1614,12 @@ static unsigned short isa_address = 0x29
  * we must create it by ourselves.
  */
 static ssize_t
-show_name(struct device *dev, struct device_attribute *devattr, char *buf)
+name_show(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%s\n", data->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static struct w83781d_data *w83781d_data_if_isa(void)
 {
diff -u -p a/drivers/hwmon/adt7x10.c b/drivers/hwmon/adt7x10.c
--- a/drivers/hwmon/adt7x10.c
+++ b/drivers/hwmon/adt7x10.c
@@ -331,9 +331,8 @@ static ssize_t adt7x10_show_alarm(struct
 	return sprintf(buf, "%d\n", !!(ret & attr->index));
 }

-static ssize_t adt7x10_show_name(struct device *dev,
-				 struct device_attribute *da,
-				 char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *da,
+			 char *buf)
 {
 	struct adt7x10_data *data = dev_get_drvdata(dev);

@@ -359,7 +358,7 @@ static SENSOR_DEVICE_ATTR(temp1_max_alar
 			  NULL, ADT7X10_STAT_T_HIGH);
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, adt7x10_show_alarm,
 			  NULL, ADT7X10_STAT_T_CRIT);
-static DEVICE_ATTR(name, S_IRUGO, adt7x10_show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static struct attribute *adt7x10_attributes[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -856,16 +856,17 @@ static ssize_t set_pwmfreq(struct device
 	return count;
 }

-static ssize_t show_pwm_at_crit(struct device *dev,
-				struct device_attribute *devattr, char *buf)
+static ssize_t pwm_use_point2_pwm_at_crit_show(struct device *dev,
+					       struct device_attribute *devattr,
+					       char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
 	return sprintf(buf, "%d\n", !!(data->config4 & CONFIG4_MAXDUTY));
 }

-static ssize_t set_pwm_at_crit(struct device *dev,
-			       struct device_attribute *devattr,
-			       const char *buf, size_t count)
+static ssize_t pwm_use_point2_pwm_at_crit_store(struct device *dev,
+						struct device_attribute *devattr,
+						const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct adt7475_data *data = i2c_get_clientdata(client);
@@ -888,15 +889,15 @@ static ssize_t set_pwm_at_crit(struct de
 	return count;
 }

-static ssize_t show_vrm(struct device *dev, struct device_attribute *devattr,
+static ssize_t vrm_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
 	struct adt7475_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", (int)data->vrm);
 }

-static ssize_t set_vrm(struct device *dev, struct device_attribute *devattr,
-		       const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
 {
 	struct adt7475_data *data = dev_get_drvdata(dev);
 	long val;
@@ -910,8 +911,8 @@ static ssize_t set_vrm(struct device *de
 	return count;
 }

-static ssize_t show_vid(struct device *dev, struct device_attribute *devattr,
-			char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
 {
 	struct adt7475_data *data = adt7475_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
@@ -1057,11 +1058,10 @@ static SENSOR_DEVICE_ATTR_2(pwm3_auto_po
 			    set_pwm, MAX, 2);

 /* Non-standard name, might need revisiting */
-static DEVICE_ATTR(pwm_use_point2_pwm_at_crit, S_IWUSR | S_IRUGO,
-		   show_pwm_at_crit, set_pwm_at_crit);
+static DEVICE_ATTR_RW(pwm_use_point2_pwm_at_crit);

-static DEVICE_ATTR(vrm, S_IWUSR | S_IRUGO, show_vrm, set_vrm);
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR_RW(vrm);
+static DEVICE_ATTR_RO(cpu0_vid);

 static struct attribute *adt7475_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/dme1737.c b/drivers/hwmon/dme1737.c
--- a/drivers/hwmon/dme1737.c
+++ b/drivers/hwmon/dme1737.c
@@ -1468,7 +1468,7 @@ exit:
  * Miscellaneous sysfs attributes
  * --------------------------------------------------------------------- */

-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
+static ssize_t vrm_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -1477,8 +1477,8 @@ static ssize_t show_vrm(struct device *d
 	return sprintf(buf, "%d\n", data->vrm);
 }

-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -1495,15 +1495,15 @@ static ssize_t set_vrm(struct device *de
 	return count;
 }

-static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
-			char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct dme1737_data *data = dme1737_update_device(dev);

 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }

-static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct dme1737_data *data = dev_get_drvdata(dev);
@@ -1645,9 +1645,9 @@ SENSOR_DEVICE_ATTR_PWM_5TO6(6);

 /* Misc */

-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);   /* for ISA devices */
+static DEVICE_ATTR_RW(vrm);
+static DEVICE_ATTR_RO(cpu0_vid);
+static DEVICE_ATTR_RO(name);   /* for ISA devices */

 /*
  * This struct holds all the attributes that are always present and need to be
diff -u -p a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
--- a/drivers/hwmon/via-cputemp.c
+++ b/drivers/hwmon/via-cputemp.c
@@ -88,8 +88,8 @@ static ssize_t show_temp(struct device *
 	return sprintf(buf, "%lu\n", ((unsigned long)eax & 0xffffff) * 1000);
 }

-static ssize_t show_cpu_vid(struct device *dev,
-			    struct device_attribute *devattr, char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *devattr, char *buf)
 {
 	struct via_cputemp_data *data = dev_get_drvdata(dev);
 	u32 eax, edx;
@@ -119,7 +119,7 @@ static const struct attribute_group via_
 };

 /* Optional attributes */
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_cpu_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

 static int via_cputemp_probe(struct platform_device *pdev)
 {
diff -u -p a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -98,8 +98,8 @@ EXPORT_SYMBOL(max1111_read_channel);
  * likely to be used by hwmon applications to distinguish between
  * different devices, explicitly add a name attribute here.
  */
-static ssize_t show_name(struct device *dev,
-			 struct device_attribute *attr, char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	return sprintf(buf, "%s\n", to_spi_device(dev)->modalias);
 }
@@ -125,7 +125,7 @@ static ssize_t show_adc(struct device *d
 #define MAX1111_ADC_ATTR(_id)		\
 	SENSOR_DEVICE_ATTR(in##_id##_input, S_IRUGO, show_adc, NULL, _id)

-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);
 static MAX1111_ADC_ATTR(0);
 static MAX1111_ADC_ATTR(1);
 static MAX1111_ADC_ATTR(2);
diff -u -p a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -604,8 +604,8 @@ show_fan_offset(4);

 /* vid, vrm, alarms */

-static ssize_t show_vid_reg(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct lm85_data *data = lm85_update_device(dev);
 	int vid;
@@ -621,17 +621,17 @@ static ssize_t show_vid_reg(struct devic
 	return sprintf(buf, "%d\n", vid);
 }

-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

-static ssize_t show_vrm_reg(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t vrm_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct lm85_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%ld\n", (long) data->vrm);
 }

-static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct lm85_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -648,16 +648,16 @@ static ssize_t store_vrm_reg(struct devi
 	return count;
 }

-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
+static DEVICE_ATTR_RW(vrm);

-static ssize_t show_alarms_reg(struct device *dev, struct device_attribute
-		*attr, char *buf)
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm85_data *data = lm85_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 		char *buf)
diff -u -p a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3127,14 +3127,14 @@ static const struct sensor_template_grou
 };

 static ssize_t
-show_vid(struct device *dev, struct device_attribute *attr, char *buf)
+cpu0_vid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct nct6775_data *data = dev_get_drvdata(dev);

 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }

-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

 /* Case open detection */

diff -u -p a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -2156,17 +2156,18 @@ static SENSOR_DEVICE_ATTR(pwm2_auto_spin
 			  show_pwm_auto_spinup_time,
 			  store_pwm_auto_spinup_time, 1);

-static ssize_t show_pwm_auto_prochot_ramp(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t pwm_auto_prochot_ramp_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
 	return sprintf(buf, "%d\n",
 		       LM93_RAMP_FROM_REG(data->pwm_ramp_ctl >> 4 & 0x0f));
 }

-static ssize_t store_pwm_auto_prochot_ramp(struct device *dev,
-						struct device_attribute *attr,
-						const char *buf, size_t count)
+static ssize_t pwm_auto_prochot_ramp_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
 {
 	struct lm93_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -2186,21 +2187,20 @@ static ssize_t store_pwm_auto_prochot_ra
 	return count;
 }

-static DEVICE_ATTR(pwm_auto_prochot_ramp, S_IRUGO | S_IWUSR,
-			show_pwm_auto_prochot_ramp,
-			store_pwm_auto_prochot_ramp);
+static DEVICE_ATTR_RW(pwm_auto_prochot_ramp);

-static ssize_t show_pwm_auto_vrdhot_ramp(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t pwm_auto_vrdhot_ramp_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
 	return sprintf(buf, "%d\n",
 		       LM93_RAMP_FROM_REG(data->pwm_ramp_ctl & 0x0f));
 }

-static ssize_t store_pwm_auto_vrdhot_ramp(struct device *dev,
-						struct device_attribute *attr,
-						const char *buf, size_t count)
+static ssize_t pwm_auto_vrdhot_ramp_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
 {
 	struct lm93_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -2220,9 +2220,7 @@ static ssize_t store_pwm_auto_vrdhot_ram
 	return 0;
 }

-static DEVICE_ATTR(pwm_auto_vrdhot_ramp, S_IRUGO | S_IWUSR,
-			show_pwm_auto_vrdhot_ramp,
-			store_pwm_auto_vrdhot_ramp);
+static DEVICE_ATTR_RW(pwm_auto_vrdhot_ramp);

 static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
 			char *buf)
@@ -2378,7 +2376,7 @@ static SENSOR_DEVICE_ATTR(prochot1_inter
 static SENSOR_DEVICE_ATTR(prochot2_interval, S_IWUSR | S_IRUGO,
 			  show_prochot_interval, store_prochot_interval, 1);

-static ssize_t show_prochot_override_duty_cycle(struct device *dev,
+static ssize_t prochot_override_duty_cycle_show(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
 {
@@ -2386,9 +2384,10 @@ static ssize_t show_prochot_override_dut
 	return sprintf(buf, "%d\n", data->prochot_override & 0x0f);
 }

-static ssize_t store_prochot_override_duty_cycle(struct device *dev,
-						struct device_attribute *attr,
-						const char *buf, size_t count)
+static ssize_t prochot_override_duty_cycle_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf,
+						 size_t count)
 {
 	struct lm93_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -2408,20 +2407,18 @@ static ssize_t store_prochot_override_du
 	return count;
 }

-static DEVICE_ATTR(prochot_override_duty_cycle, S_IRUGO | S_IWUSR,
-			show_prochot_override_duty_cycle,
-			store_prochot_override_duty_cycle);
+static DEVICE_ATTR_RW(prochot_override_duty_cycle);

-static ssize_t show_prochot_short(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t prochot_short_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
 	return sprintf(buf, "%d\n", (data->config & 0x10) ? 1 : 0);
 }

-static ssize_t store_prochot_short(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t count)
+static ssize_t prochot_short_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
 {
 	struct lm93_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -2442,8 +2439,7 @@ static ssize_t store_prochot_short(struc
 	return count;
 }

-static DEVICE_ATTR(prochot_short, S_IRUGO | S_IWUSR,
-		   show_prochot_short, store_prochot_short);
+static DEVICE_ATTR_RW(prochot_short);

 static ssize_t show_vrdhot(struct device *dev, struct device_attribute *attr,
 				char *buf)
@@ -2457,23 +2453,23 @@ static ssize_t show_vrdhot(struct device
 static SENSOR_DEVICE_ATTR(vrdhot1, S_IRUGO, show_vrdhot, NULL, 0);
 static SENSOR_DEVICE_ATTR(vrdhot2, S_IRUGO, show_vrdhot, NULL, 1);

-static ssize_t show_gpio(struct device *dev, struct device_attribute *attr,
-				char *buf)
+static ssize_t gpio_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
 	return sprintf(buf, "%d\n", LM93_GPI_FROM_REG(data->gpi));
 }

-static DEVICE_ATTR(gpio, S_IRUGO, show_gpio, NULL);
+static DEVICE_ATTR_RO(gpio);

-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
-				char *buf)
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm93_data *data = lm93_update_device(dev);
 	return sprintf(buf, "%d\n", LM93_ALARMS_FROM_REG(data->block1));
 }

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static struct attribute *lm93_attrs[] = {
 	&sensor_dev_attr_in1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -54,8 +54,8 @@ struct lm70 {
 };

 /* sysfs hook function */
-static ssize_t lm70_sense_temp(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t temp1_input_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct lm70 *p_lm70 = dev_get_drvdata(dev);
 	struct spi_device *spi = p_lm70->spi;
@@ -120,7 +120,7 @@ out:
 	return status;
 }

-static DEVICE_ATTR(temp1_input, S_IRUGO, lm70_sense_temp, NULL);
+static DEVICE_ATTR_RO(temp1_input);

 static struct attribute *lm70_attrs[] = {
 	&dev_attr_temp1_input.attr,
diff -u -p a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -304,22 +304,23 @@ show_in_offset(3);
 show_in_offset(4);

 /* Temperature */
-static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+static ssize_t temp1_input_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp));
 }

-static ssize_t show_temp_over(struct device *dev, struct device_attribute *attr,
-			      char *buf)
+static ssize_t temp1_max_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }

-static ssize_t set_temp_over(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t temp1_max_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
 {
 	struct sis5595_data *data = dev_get_drvdata(dev);
 	long val;
@@ -336,15 +337,16 @@ static ssize_t set_temp_over(struct devi
 	return count;
 }

-static ssize_t show_temp_hyst(struct device *dev, struct device_attribute *attr,
-			      char *buf)
+static ssize_t temp1_max_hyst_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_hyst));
 }

-static ssize_t set_temp_hyst(struct device *dev, struct device_attribute *attr,
-			     const char *buf, size_t count)
+static ssize_t temp1_max_hyst_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
 {
 	struct sis5595_data *data = dev_get_drvdata(dev);
 	long val;
@@ -361,11 +363,9 @@ static ssize_t set_temp_hyst(struct devi
 	return count;
 }

-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
-static DEVICE_ATTR(temp1_max, S_IRUGO | S_IWUSR,
-		show_temp_over, set_temp_over);
-static DEVICE_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR,
-		show_temp_hyst, set_temp_hyst);
+static DEVICE_ATTR_RO(temp1_input);
+static DEVICE_ATTR_RW(temp1_max);
+static DEVICE_ATTR_RW(temp1_max_hyst);

 /* 2 Fans */
 static ssize_t show_fan(struct device *dev, struct device_attribute *da,
@@ -492,13 +492,13 @@ show_fan_offset(1);
 show_fan_offset(2);

 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct sis5595_data *data = sis5595_update_device(dev);
 	return sprintf(buf, "%d\n", data->alarms);
 }
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
 			  char *buf)
@@ -516,13 +516,13 @@ static SENSOR_DEVICE_ATTR(fan1_alarm, S_
 static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);
 static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 15);

-static ssize_t show_name(struct device *dev, struct device_attribute *attr,
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
 	struct sis5595_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%s\n", data->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static struct attribute *sis5595_attributes[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/max197.c b/drivers/hwmon/max197.c
--- a/drivers/hwmon/max197.c
+++ b/drivers/hwmon/max197.c
@@ -207,8 +207,8 @@ unlock:
 	return ret;
 }

-static ssize_t max197_show_name(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	return sprintf(buf, "%s\n", pdev->name);
@@ -231,7 +231,7 @@ static ssize_t max197_show_name(struct d
 	&sensor_dev_attr_in##chan##_max.dev_attr.attr,			\
 	&sensor_dev_attr_in##chan##_min.dev_attr.attr

-static DEVICE_ATTR(name, S_IRUGO, max197_show_name, NULL);
+static DEVICE_ATTR_RO(name);

 MAX197_SENSOR_DEVICE_ATTR_CH(0);
 MAX197_SENSOR_DEVICE_ATTR_CH(1);
diff -u -p a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -262,8 +262,8 @@ static struct adm9240_data *adm9240_upda
 /*** sysfs accessors ***/

 /* temperature */
-static ssize_t show_temp(struct device *dev, struct device_attribute *dummy,
-		char *buf)
+static ssize_t temp1_input_show(struct device *dev,
+				struct device_attribute *dummy, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", data->temp / 128 * 500); /* 9-bit value */
@@ -298,7 +298,7 @@ static ssize_t set_max(struct device *de
 	return count;
 }

-static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL);
+static DEVICE_ATTR_RO(temp1_input);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
 		show_max, set_max, 0);
 static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO,
@@ -501,13 +501,13 @@ fan(1);
 fan(2);

 /* alarms */
-static ssize_t show_alarms(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev,
 		struct device_attribute *attr, char *buf)
@@ -527,25 +527,25 @@ static SENSOR_DEVICE_ATTR(fan1_alarm, S_
 static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);

 /* vid */
-static ssize_t show_vid(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }
-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

 /* analog output */
-static ssize_t show_aout(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t aout_output_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct adm9240_data *data = adm9240_update_device(dev);
 	return sprintf(buf, "%d\n", AOUT_FROM_REG(data->aout));
 }

-static ssize_t set_aout(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t aout_output_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct adm9240_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -562,7 +562,7 @@ static ssize_t set_aout(struct device *d
 	mutex_unlock(&data->update_lock);
 	return count;
 }
-static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
+static DEVICE_ATTR_RW(aout_output);

 static ssize_t chassis_clear(struct device *dev,
 		struct device_attribute *attr,
diff -u -p a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -264,8 +264,8 @@ static ssize_t get_pwm_en(struct device
 	return sprintf(buf, "%d\n", PWM_EN_FROM_REG(data->pwm[attr->index]));
 }

-static ssize_t get_alarms(struct device *dev, struct device_attribute
-			  *devattr, char *buf)
+static ssize_t alarms_show(struct device *dev,
+			   struct device_attribute *devattr, char *buf)
 {
 	struct smsc47m1_data *data = smsc47m1_update_device(dev, 0);
 	return sprintf(buf, "%d\n", data->alarms);
@@ -440,16 +440,16 @@ fan_present(1);
 fan_present(2);
 fan_present(3);

-static DEVICE_ATTR(alarms, S_IRUGO, get_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

-static ssize_t show_name(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct smsc47m1_data *data = dev_get_drvdata(dev);

 	return sprintf(buf, "%s\n", data->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static struct attribute *smsc47m1_attributes_fan1[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/f71805f.c b/drivers/hwmon/f71805f.c
--- a/drivers/hwmon/f71805f.c
+++ b/drivers/hwmon/f71805f.c
@@ -946,24 +946,24 @@ static ssize_t set_temp_hyst(struct devi
 	return count;
 }

-static ssize_t show_alarms_in(struct device *dev, struct device_attribute
-			      *devattr, char *buf)
+static ssize_t alarms_in_show(struct device *dev,
+			      struct device_attribute *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);

 	return sprintf(buf, "%lu\n", data->alarms & 0x7ff);
 }

-static ssize_t show_alarms_fan(struct device *dev, struct device_attribute
-			       *devattr, char *buf)
+static ssize_t alarms_fan_show(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);

 	return sprintf(buf, "%lu\n", (data->alarms >> 16) & 0x07);
 }

-static ssize_t show_alarms_temp(struct device *dev, struct device_attribute
-				*devattr, char *buf)
+static ssize_t alarms_temp_show(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
 	struct f71805f_data *data = f71805f_update_device(dev);

@@ -980,8 +980,8 @@ static ssize_t show_alarm(struct device
 	return sprintf(buf, "%lu\n", (data->alarms >> bitnr) & 1);
 }

-static ssize_t show_name(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct f71805f_data *data = dev_get_drvdata(dev);

@@ -1176,11 +1176,11 @@ static SENSOR_DEVICE_ATTR(temp3_alarm, S
 static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 16);
 static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 17);
 static SENSOR_DEVICE_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 18);
-static DEVICE_ATTR(alarms_in, S_IRUGO, show_alarms_in, NULL);
-static DEVICE_ATTR(alarms_fan, S_IRUGO, show_alarms_fan, NULL);
-static DEVICE_ATTR(alarms_temp, S_IRUGO, show_alarms_temp, NULL);
+static DEVICE_ATTR_RO(alarms_in);
+static DEVICE_ATTR_RO(alarms_fan);
+static DEVICE_ATTR_RO(alarms_temp);

-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static struct attribute *f71805f_attributes[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -63,11 +63,11 @@ struct hwmon_thermal_data {
 };

 static ssize_t
-show_name(struct device *dev, struct device_attribute *attr, char *buf)
+name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s\n", to_hwmon_device(dev)->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static struct attribute *hwmon_dev_attrs[] = {
 	&dev_attr_name.attr,
diff -u -p a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -483,25 +483,25 @@ sysfs_temp(3);
 sysfs_temp(4);

 /* VID */
-static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t cpu0_vid_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
 }

-static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
+static DEVICE_ATTR_RO(cpu0_vid);

 /* VRM */
-static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t vrm_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
 {
 	struct asb100_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%d\n", data->vrm);
 }

-static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t vrm_store(struct device *dev, struct device_attribute *attr,
+			 const char *buf, size_t count)
 {
 	struct asb100_data *data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -519,16 +519,16 @@ static ssize_t set_vrm(struct device *de
 }

 /* Alarms */
-static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+static DEVICE_ATTR_RW(vrm);

-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 		char *buf)
@@ -550,15 +550,15 @@ static SENSOR_DEVICE_ATTR(temp2_alarm, S
 static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13);

 /* 1 PWM */
-static ssize_t show_pwm1(struct device *dev, struct device_attribute *attr,
-		char *buf)
+static ssize_t pwm1_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", ASB100_PWM_FROM_REG(data->pwm & 0x0f));
 }

-static ssize_t set_pwm1(struct device *dev, struct device_attribute *attr,
-		const char *buf, size_t count)
+static ssize_t pwm1_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
@@ -577,15 +577,16 @@ static ssize_t set_pwm1(struct device *d
 	return count;
 }

-static ssize_t show_pwm_enable1(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t pwm1_enable_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct asb100_data *data = asb100_update_device(dev);
 	return sprintf(buf, "%d\n", (data->pwm & 0x80) ? 1 : 0);
 }

-static ssize_t set_pwm_enable1(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t pwm1_enable_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct asb100_data *data = i2c_get_clientdata(client);
@@ -604,9 +605,8 @@ static ssize_t set_pwm_enable1(struct de
 	return count;
 }

-static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm1, set_pwm1);
-static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
-		show_pwm_enable1, set_pwm_enable1);
+static DEVICE_ATTR_RW(pwm1);
+static DEVICE_ATTR_RW(pwm1_enable);

 static struct attribute *asb100_attributes[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -181,8 +181,8 @@ static ssize_t show_temp_hyst(struct dev
 		       - TEMP_FROM_REG(data->temp[t_hyst]));
 }

-static ssize_t show_temp_min_hyst(struct device *dev,
-				  struct device_attribute *attr, char *buf)
+static ssize_t temp1_min_hyst_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
 	struct lm92_data *data = lm92_update_device(dev);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[t_min])
@@ -213,7 +213,7 @@ static ssize_t set_temp_hyst(struct devi
 	return count;
 }

-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct lm92_data *data = lm92_update_device(dev);
@@ -235,11 +235,11 @@ static SENSOR_DEVICE_ATTR(temp1_crit_hys
 			  set_temp_hyst, t_crit);
 static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO, show_temp, set_temp,
 			  t_min);
-static DEVICE_ATTR(temp1_min_hyst, S_IRUGO, show_temp_min_hyst, NULL);
+static DEVICE_ATTR_RO(temp1_min_hyst);
 static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp, set_temp,
 			  t_max);
 static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO, show_temp_hyst, NULL, t_max);
-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);
 static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL, 2);
 static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL, 1);
diff -u -p a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -580,14 +580,14 @@ show_fan_offset(1);
 show_fan_offset(2);

 /* Alarms */
-static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+static ssize_t alarms_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct via686a_data *data = via686a_update_device(dev);
 	return sprintf(buf, "%u\n", data->alarms);
 }

-static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+static DEVICE_ATTR_RO(alarms);

 static ssize_t show_alarm(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -607,13 +607,13 @@ static SENSOR_DEVICE_ATTR(temp3_alarm, S
 static SENSOR_DEVICE_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6);
 static SENSOR_DEVICE_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7);

-static ssize_t show_name(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct via686a_data *data = dev_get_drvdata(dev);
 	return sprintf(buf, "%s\n", data->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);

 static struct attribute *via686a_attributes[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
diff -u -p a/drivers/hwmon/pc87427.c b/drivers/hwmon/pc87427.c
--- a/drivers/hwmon/pc87427.c
+++ b/drivers/hwmon/pc87427.c
@@ -943,14 +943,14 @@ static const struct attribute_group pc87
 	{ .attrs = pc87427_attributes_temp[5] },
 };

-static ssize_t show_name(struct device *dev, struct device_attribute
-			 *devattr, char *buf)
+static ssize_t name_show(struct device *dev, struct device_attribute *devattr,
+			 char *buf)
 {
 	struct pc87427_data *data = dev_get_drvdata(dev);

 	return sprintf(buf, "%s\n", data->name);
 }
-static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+static DEVICE_ATTR_RO(name);


 /*
diff -u -p a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -77,8 +77,8 @@ static irqreturn_t fan_alarm_irq_handler
 	return IRQ_NONE;
 }

-static ssize_t show_fan_alarm(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t fan1_alarm_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
 	struct gpio_fan_alarm *alarm = fan_data->alarm;
@@ -90,7 +90,7 @@ static ssize_t show_fan_alarm(struct dev
 	return sprintf(buf, "%d\n", value);
 }

-static DEVICE_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL);
+static DEVICE_ATTR_RO(fan1_alarm);

 static int fan_alarm_init(struct gpio_fan_data *fan_data,
 			  struct gpio_fan_alarm *alarm)
@@ -188,8 +188,8 @@ static int rpm_to_speed_index(struct gpi
 	return fan_data->num_speed - 1;
 }

-static ssize_t show_pwm(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t pwm1_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
 	u8 pwm = fan_data->speed_index * 255 / (fan_data->num_speed - 1);
@@ -197,8 +197,8 @@ static ssize_t show_pwm(struct device *d
 	return sprintf(buf, "%d\n", pwm);
 }

-static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
-		       const char *buf, size_t count)
+static ssize_t pwm1_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
 	unsigned long pwm;
@@ -224,16 +224,17 @@ exit_unlock:
 	return ret;
 }

-static ssize_t show_pwm_enable(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t pwm1_enable_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);

 	return sprintf(buf, "%d\n", fan_data->pwm_enable);
 }

-static ssize_t set_pwm_enable(struct device *dev, struct device_attribute *attr,
-			      const char *buf, size_t count)
+static ssize_t pwm1_enable_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
 	unsigned long val;
@@ -257,22 +258,22 @@ static ssize_t set_pwm_enable(struct dev
 	return count;
 }

-static ssize_t show_pwm_mode(struct device *dev,
-			     struct device_attribute *attr, char *buf)
+static ssize_t pwm1_mode_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "0\n");
 }

-static ssize_t show_rpm_min(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+static ssize_t fan1_min_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);

 	return sprintf(buf, "%d\n", fan_data->speed[0].rpm);
 }

-static ssize_t show_rpm_max(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+static ssize_t fan1_max_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);

@@ -280,8 +281,8 @@ static ssize_t show_rpm_max(struct devic
 		       fan_data->speed[fan_data->num_speed - 1].rpm);
 }

-static ssize_t show_rpm(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static ssize_t fan1_input_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);

@@ -313,14 +314,13 @@ exit_unlock:
 	return ret;
 }

-static DEVICE_ATTR(pwm1, S_IRUGO | S_IWUSR, show_pwm, set_pwm);
-static DEVICE_ATTR(pwm1_enable, S_IRUGO | S_IWUSR,
-		   show_pwm_enable, set_pwm_enable);
-static DEVICE_ATTR(pwm1_mode, S_IRUGO, show_pwm_mode, NULL);
-static DEVICE_ATTR(fan1_min, S_IRUGO, show_rpm_min, NULL);
-static DEVICE_ATTR(fan1_max, S_IRUGO, show_rpm_max, NULL);
-static DEVICE_ATTR(fan1_input, S_IRUGO, show_rpm, NULL);
-static DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR, show_rpm, set_rpm);
+static DEVICE_ATTR_RW(pwm1);
+static DEVICE_ATTR_RW(pwm1_enable);
+static DEVICE_ATTR_RO(pwm1_mode);
+static DEVICE_ATTR_RO(fan1_min);
+static DEVICE_ATTR_RO(fan1_max);
+static DEVICE_ATTR_RO(fan1_input);
+static DEVICE_ATTR(fan1_target, S_IRUGO | S_IWUSR, fan1_input_show, set_rpm);

 static umode_t gpio_fan_is_visible(struct kobject *kobj,
 				   struct attribute *attr, int index)
