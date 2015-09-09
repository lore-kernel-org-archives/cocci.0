From: kieranbingham@gmail.com (Kieran Bingham)
Date: Wed, 9 Sep 2015 11:56:00 +0100
Subject: [Cocci] Comments removed on (adjacent) lines not touched ... ?
Message-ID: <CAB3z_Rpt-nF3=V_OFcBiLkYvbPefPZXA0DsRm+BUJU6gG95RMw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Reviewing the changes made by my s-patch, I've come across the following hunk :

============================================================
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
...
@@ -529,13 +529,7 @@ static const struct dev_pm_ops jc42_dev_pm_ops = {
 #define JC42_DEV_PM_OPS (&jc42_dev_pm_ops)
 #else
 #define JC42_DEV_PM_OPS NULL
-#endif /* CONFIG_PM */
-
-static const struct i2c_device_id jc42_id[] = {
-       { "jc42", 0 },
-       { }
-};
-MODULE_DEVICE_TABLE(i2c, jc42_id);
+#endif

 static struct i2c_driver jc42_driver = {
        .class          = I2C_CLASS_SPD,
============================================================

Is this removal of the /* CONFIG_PM */ expected behaviour?

I guess under the hood, Coccinelle is stripping comments from code to
make parsing possible/easier?

--
Regards

Kieran
