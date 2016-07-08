From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 8 Jul 2016 14:17:41 +0200
Subject: [Cocci] Add a parameter to function
In-Reply-To: <f2e0fa46cc354563ae8bfd52fc5f35fa@vprd-opci0018.b-com.local>
References: <f2e0fa46cc354563ae8bfd52fc5f35fa@vprd-opci0018.b-com.local>
Message-ID: <trinity-da8ddaac-446c-47fa-bf7d-3d93029e9604-1467980261400@3capp-webde-bs29>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> The problem I have is when I have a void or empty declaration.

Do you wonder about the need to distinguish three cases
for your source code transformation?


> Is there a better way to achieve this ?

How do you think about a bit of fine-tuning like the following?


@replace_void_parameter@
identifier fn;
@@
 fn(
-   void
+   int s
   )
 { ... }

@single_parameter_addition@
identifier fn;
@@
 fn(
+   int s
   )
 { ... }

@more_parameters
 depends on !(replace_void_parameter || single_parameter_addition)@
identifier fn;
parameter list pl;
@@
 fn(
+   int s,
    pl)
 { ... }


Are you looking for an approach which might be more convenient and fast?

Regards,
Markus
