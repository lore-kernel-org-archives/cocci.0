From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 12 Nov 2014 11:51:44 +0100
Subject: [Cocci] [PATCH with SmPL?] staging: rtl8188eu: Adjustments
 around jump labels
In-Reply-To: <alpine.DEB.2.10.1410311911070.2481@hadrien>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <544954FD.8040607@users.sourceforge.net>
 <20141029084702.GA18675@kroah.com> <5453CD0D.9010206@users.sourceforge.net>
 <alpine.DEB.2.10.1410311900201.2481@hadrien>
 <5453D013.9000007@users.sourceforge.net>
 <alpine.DEB.2.10.1410311911070.2481@hadrien>
Message-ID: <54633BC0.3030700@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>>>> @@ -212,8 +212,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16
>>>> _size_byte, u8  *pbuf)
>>>>  exit:
>>>>  	kfree(efuseTbl);
>>>>
>>>> -	if (eFuseWord)
>>>> -		kfree(eFuseWord);
>>>> +	kfree(eFuseWord);
>>>
>>> I think that this code has been updated already.  It would be better to
>>> add labels so that kfree is only executed when needed.
>>
>> Are there any chances to achieve the suggested fine-tuning for jump labels
>> also with another semantic patch approach?
> 
> No, I don't think so.  The pattern is not regular enough.

Now I have got a different impression for corresponding improvement possibilities.


elfring at Sonne:~/Projekte/Linux/stable-patched> spatch.opt -debug -sp-file ~/Projekte/Coccinelle/janitor/move_function_call_before_jump_label1.cocci drivers/staging/rtl8188eu/core/rtw_efuse.c
init_defs_builtins: /usr/local/share/coccinelle/standard.h
-----------------------------------------------------------------------
processing semantic patch file: /home/elfring/Projekte/Coccinelle/janitor/move_function_call_before_jump_label1.cocci
with isos from: /usr/local/share/coccinelle/standard.iso
-----------------------------------------------------------------------
@move_function_call_before_jump_label@
expression x;
identifier fu, label;
type t;
@@
 t fu(...)
 {
  ... when any
  x = kzalloc(...);
  if (x == NULL) {
     ...
     goto label;
  }
  ... when any
+    kfree(x);
  label:
-    kfree(x);
  ...
 }

HANDLING: drivers/staging/rtl8188eu/core/rtw_efuse.c
-----------------------------------------------------------------------
let's go
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
move_function_call_before_jump_label = 
-----------------------------------------------------------------------
dependencies for rule move_function_call_before_jump_label satisfied:
binding in = []
binding relevant in = []
     (ONCE) USING optional_storage builtin isomorphism
     transformation info returned:
          transform state: 5
               with rule_elem: 
                                 <<< kfree(move_function_call_before_jump_label:x);
                               move_function_call_before_jump_label:label:
               with binding: [move_function_call_before_jump_label.x --> efuseTbl]
          transform state: 204
               with rule_elem: -kfree-(-move_function_call_before_jump_label:x-)-;
               with binding: [move_function_call_before_jump_label.x --> efuseTbl]
     binding out = []
     transform one node: 204
     transform one node: 5
-----------------------------------------------------------------------
Finished
-----------------------------------------------------------------------
diff = 
--- drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ /tmp/cocci-output-4498-349827-rtw_efuse.c
@@ -209,8 +209,8 @@ efuse_phymap_to_logical(u8 *phymap, u16
        /*  5. Calculate Efuse utilization. */
        /*  */
 
+kfree(efuseTbl);
 exit:
-       kfree(efuseTbl);
 
        kfree(eFuseWord);
 }
Check duplication for 1 files



Can my update suggestion be generalised a bit more for the movement of specific jump labels
towards the end of a function implementation like in the use case "efuse_phymap_to_logical()"?

Regards,
Markus
