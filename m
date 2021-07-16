Return-Path: <SRS0=v5gi=MW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2955DC4338F
	for <cocci@archiver.kernel.org>; Fri, 30 Jul 2021 10:59:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CDC60FE7
	for <cocci@archiver.kernel.org>; Fri, 30 Jul 2021 10:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92CDC60FE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16UAxsac023569;
	Fri, 30 Jul 2021 12:59:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 65DEF7779;
	Fri, 30 Jul 2021 12:59:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DC3FC3F5A
 for <cocci@systeme.lip6.fr>; Fri, 16 Jul 2021 11:31:05 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:12c])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16G9V3UK013006
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 16 Jul 2021 11:31:04 +0200 (CEST)
Received: by mail-lf1-x12c.google.com with SMTP id g22so3028556lfu.0
 for <cocci@systeme.lip6.fr>; Fri, 16 Jul 2021 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=dcnboaz2KVm8+pj1VAu33I8AMFm21L+DwfHTbvB+hpw=;
 b=c3+YR73aOtD5SvsTihYJaIHgPkWRvPvayY1/8GhGkHj98XLeHVilYtp0ICfw8ryqXA
 BVkIr6qgXy196NEGSZzQJkIvr7T52944dUtReD1COvt7Keo8w1XAo41L24yxvk0wjzAw
 Sa5oyFohDez9ri5so2sPpP1AbRk1R7Ouf9frxYFXY7PzJQqBl+X6xY8HGWoyKRn/znE3
 TSdR/CDxShhZTGQVXspkpT0P4WWITYRMd6KPIwxg/hdPm3zypYpvDPg+jvCsJj0EDPSL
 UNVekrG8gZgQOVixt29actzOX/UPqUUauLL8YT4IC/X98I7Zl3gDeJhEGemptoq0hD8H
 gpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=dcnboaz2KVm8+pj1VAu33I8AMFm21L+DwfHTbvB+hpw=;
 b=oTzrt9DIfG6MLNi2M5+D9Wztm/pXuiXvwCQsMy0/UPI7fJp8KASipV1Q5ig3SY1lDF
 KecNBk0JKlyTXK3MCLwT5FFqOsjE2iWczMGctG23hgLJT4PG0j4kKkQs6vS1x6Xrgcdd
 9u2Ba/DynvnWtafeq135TwSysRFT2ud6JqxTyVlNtAkShv3DqMiSIZB2cSpNbe1IfAhc
 nrzIV8o31szeqPLgIHAH999k1uQJdIcyOtFpxZDlI1fYvQ0GVObKmlZZr3Vr4Xw+NU9f
 Y0tRc1fSjbuhm6wWMsrxK0pn9t1mL3SYPDwF96UlTH5Wf44m+oG//r6OX1HXgEJgxUX8
 dw4Q==
X-Gm-Message-State: AOAM5311m4sjdSTgVUGC2gcWvdKXGhGsDnRaw3Fx+nCiSu9sbYf31wnl
 o/LG1UU5MgNGsgWT7xAT7nvHAja5T0uO+o2X/r2kgMTN1cM=
X-Google-Smtp-Source: ABdhPJz8K2GlhaXoMlvA+iKOwh7NCkrSotVQstwEjEn0owoE5QfpT/IDEDDlv4iwlU2nK11qe+d2v6FNPOsfowwVmww=
X-Received: by 2002:a05:6512:400b:: with SMTP id
 br11mr6961429lfb.36.1626427863463; 
 Fri, 16 Jul 2021 02:31:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:4a06:0:0:0:0:0 with HTTP; Fri, 16 Jul 2021 02:31:03
 -0700 (PDT)
From: =?UTF-8?B?QW5kcmV3IPCfkb0gIFlvdXJ0Y2hlbmtv?= <ayourtch@gmail.com>
Date: Fri, 16 Jul 2021 09:31:03 +0000
Message-ID: <CAPi140P-O0B+BiAa7i+WbdfmG3HnA3yCZdy4+SeKa=2jRreTyg@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 30 Jul 2021 12:59:54 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 16 Jul 2021 11:31:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 30 Jul 2021 12:59:52 +0200
Subject: [Cocci] how to make substitutions at the end of the function,
 vs. the end of the block ?
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi all,

I work on the VPP project (http://fd.io/ - open source software
dataplane), and yesterday tried to use coccinelle to make a relatively
non-trivial change
as in the mail https://lists.fd.io/g/vpp-dev/message/17532 - it seemed
to be a very good candidate - boring enough to be painful to do by
hand, complex enough to make sed inadequate for it.

I came up with this semantic patch:


@ detect_func @
identifier CLI_FN, AVM, AIN, ACMD;
fresh identifier LAIN = "line_" ## AIN;

statement S1;

typedef clib_error_t, vlib_main_t, unformat_input_t, vlib_cli_command_t;
@@

static clib_error_t *CLI_FN (vlib_main_t * AVM, unformat_input_t *
AIN, vlib_cli_command_t * ACMD)
{
+ clib_error_t *e = 0;
+  unformat_input_t *LAIN;
...
+ if (!unformat_user (AIN, unformat_line_input, LAIN)) {
+    return 0;
+ }
+
-  while (unformat_check_input (AIN) != UNFORMAT_END_OF_INPUT)
+ while (unformat_check_input (LAIN) != UNFORMAT_END_OF_INPUT)
S1
<...
- return ERR;
+ e = ERR;
+ goto done;
...>
+done:
+ unformat_free(LAIN);
+ return e;
}


I attempt to run it on this test file:

ubuntu@vpp-dev:~$ cat ~/test.c
static clib_error_t *
syn_filter_enable_disable_command_fn (vlib_main_t * vm,
				      unformat_input_t * input,
				      vlib_cli_command_t * cmd)
{
  vnet_main_t *vnm = vnet_get_main ();
  u32 sw_if_index = ~0;
  int enable_disable = 1;
  int rv;

  while (unformat_check_input (input) != UNFORMAT_END_OF_INPUT)
    {
      if (unformat (input, "disable"))
	enable_disable = 0;
      else if (unformat (input, "%U", unformat_vnet_sw_interface,
			 vnm, &sw_if_index))
	;
      else
	break;
    }

  if (sw_if_index == ~0)
    return clib_error_return (0, "Please specify an interface...");

  rv = syn_filter_enable_disable (sw_if_index, enable_disable);

  switch (rv)
    {
    case 0:
      break;

    case VNET_API_ERROR_INVALID_SW_IF_INDEX:
      return clib_error_return
	(0, "Invalid interface, only works on physical ports");
      break;

    case VNET_API_ERROR_UNIMPLEMENTED:
      return clib_error_return (0,
				"Device driver doesn't support redirection");
      break;

    case VNET_API_ERROR_INVALID_VALUE:
      return clib_error_return (0, "feature arc not found");

    case VNET_API_ERROR_INVALID_VALUE_2:
      return clib_error_return (0, "feature node not found");

    default:
      return clib_error_return (0, "syn_filter_enable_disable returned %d",
				rv);
    }
  return 0;
}
ubuntu@vpp-dev:~$


However, when I run it, the "done: " label, etc. gets inserted twice:

ubuntu@vpp-dev:~$ spatch --sp-file /tmp/rules.sp
--allow-inconsistent-paths  ~/test.c
init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
HANDLING: /home/ubuntu/test.c
diff =
--- /home/ubuntu/test.c
+++ /tmp/cocci-output-56896-8f35c5-test.c
@@ -3,12 +3,18 @@ syn_filter_enable_disable_command_fn (vl
 				      unformat_input_t * input,
 				      vlib_cli_command_t * cmd)
 {
+  clib_error_t *e = 0;
+  unformat_input_t *line_input;
   vnet_main_t *vnm = vnet_get_main ();
   u32 sw_if_index = ~0;
   int enable_disable = 1;
   int rv;

-  while (unformat_check_input (input) != UNFORMAT_END_OF_INPUT)
+  if (!unformat_user(input, unformat_line_input, line_input)) {
+      return 0;
+  }
+
+while (unformat_check_input(line_input) != UNFORMAT_END_OF_INPUT)
     {
       if (unformat (input, "disable"))
 	enable_disable = 0;
@@ -48,6 +54,12 @@ syn_filter_enable_disable_command_fn (vl
     default:
       return clib_error_return (0, "syn_filter_enable_disable returned %d",
 				rv);
-    }
+    done:
+      unformat_free(line_input);
+      return e;
+  }
   return 0;
+done:
+  unformat_free(line_input);
+  return e;
 }
ubuntu@vpp-dev:~$


I get a feeling I am missing something fundamental - but RTFM did not
help much... Could anyone please nudge me in the correct direction ?

Thanks a lot!

--a
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
