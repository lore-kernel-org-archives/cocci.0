From: kumar.gala@linaro.org (Kumar Gala)
Date: Thu, 26 Jan 2017 07:45:31 -0600
Subject: [Cocci] some questions related to output formatting
Message-ID: <FAB49815-C2ED-4463-94A6-A766A21C6F9B@linaro.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

1. Is there a way to adjust the 80 char line break limit?
2. When I?m using a python script that parses a token that crosses multiple lines for some reason the output gets merged onto a single line:

-                       printk(" Min latency from hw interrupt up to 'C' int. "
-                              "handler:"
-                              " %d tcs = %d nsec\n",
+                       printk(" Min latency from hw interrupt up to 'C' int. " "handler:" " %lu tcs = %lu nsec\n?,

Is there something I should be doing special?

I?m using a modified version of Johann?s script for adjusting printf formatters:

https://systeme.lip6.fr/pipermail/cocci/2016-August/003533.html

Thanks

- k
