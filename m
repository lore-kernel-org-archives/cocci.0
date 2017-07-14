From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Fri, 14 Jul 2017 18:29:23 +0100
Subject: [Cocci] Dropping K&R support
Message-ID: <20170714172922.sziksfhmacwmoqph@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,
in OpenLDAP we're thinking of dropping K&R support macros in our
headers, but I'm having problems generating the semantic patch that
would work.

For example the LDAP_P macro in include/ldap.h. Let this serve as a
trivial example:

LDAP_F(int) some_func LDAP_P((int i, int j));

Where (on some platforms) the macros are defined as follows:

#define LDAP_P(params)    params
#define LDAP_V(type)      extern type

I'd think something like this should help convert it:

@@
@@

-LDAP_P(
 ...
-)

But with or without the above in --macro-file-builtins, I can't get this
patch to apply. Without it, I guess it's the parse error that stops
coccinelle from processing it, but with the above in
--macro-file-builtins, no diff is produced either.

Is there something wrong with the patch? Can this be done?

Thanks,

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
