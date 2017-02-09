From: johannes@sipsolutions.net (Johannes Berg)
Date: Thu, 09 Feb 2017 12:48:06 +0100
Subject: [Cocci] using "attribute" in - context?
Message-ID: <1486640886.17671.0.camel@sipsolutions.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Is there a way to make this work?

@@
identifier fam;
attribute __ro_after_init;
attribute __genl_ro_after_init;
@@
?struct genl_family fam
- __ro_after_init
+ __genl_ro_after_init
?= {...};


Thanks,
johannes
