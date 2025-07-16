Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7C6C83F27
	for <cocci@archiver.kernel.org>; Wed, 16 Jul 2025 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=sAE5oQhBpYwleAqdmAEE9m/VY3pIAZZS4tXS3v1h6VQ=;
  b=tZdw5g//HwOcE2xeV/cdUQ8GmtlHuV9hiQd3HnHn5K8IgXUzVGofkY5K
   dX1F3nuwHfQ5kUiyGDsrfxT/HVZVnM9VuafVjBem54n77tfx1xvdP/rs+
   7a1/Q5YWn5dfC8LWWooZGWA/Z50xyGpXIPUejOh8x7yQjSU2MvIx0Hseh
   4=;
X-CSE-ConnectionGUID: ddpe9XEkRlCbIgRmWsO0XA==
X-CSE-MsgGUID: 3D9EViGLSEKNGEWZ02TOWA==
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.16,316,1744063200"; 
   d="scan'208,217";a="231886735"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jul 2025 14:02:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D7F4DE0B0D; Wed, 16 Jul 2025 14:02:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C87FEE0171
	for <cocci@sympa.inria.fr>; Wed, 16 Jul 2025 14:02:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=sAE5oQhBpYwleAqdmAEE9m/VY3pIAZZS4tXS3v1h6VQ=;
  b=YHc/AxyNoEAe63+nfttNBg69OK3iccmUxfecxZ/XsdE2Wa0LRZFtYet6
   f8zFk3y3LDggydn1+xBC1PiphjZWUPznDPwO3lAcDzA4tJF+ybEm4NzIF
   hOUmHHVMgzA4VUdEY5XwX37xyf+/9TyRIHQbBdysKxzJ4U8I6H7FDaq+J
   o=;
X-CSE-ConnectionGUID: RSdAftYyRbKLhxZvKfDUFg==
X-CSE-MsgGUID: nHEX0TqfTaiTyPiG2dDiTQ==
X-IronPort-AV: E=Sophos;i="6.16,316,1744063200"; 
   d="scan'208,217";a="121510155"
Received: from 176-129-241-48.abo.bbox.fr (HELO [192.168.1.137]) ([176.129.241.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 14:02:44 +0200
Content-Type: multipart/alternative;
 boundary="------------9cV0RbKYUzDqQttOydDE7br9"
Message-ID: <e9bc7027-5eba-461d-a659-4037849e3760@inria.fr>
Date: Wed, 16 Jul 2025 14:02:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: devnoname120 <devnoname120@gmail.com>,
 Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <7c65be39-dfc3-4b9c-9acd-dd94d1225db8@Spark>
 <alpine.DEB.2.22.394.2506291925100.95572@hadrien>
 <55f3b1f1-2537-4bc3-88d3-d7da1136060a@Spark>
 <alpine.DEB.2.22.394.2506292109470.95572@hadrien>
 <1a234d32-e87d-414b-8566-490618417f6c@Spark>
 <c08d6fa1-e53c-d21-7892-1132133087fb@inria.fr>
 <68edca4d-74e7-4b83-9813-03d8fd7eae4e@Spark>
 <6ed53f2e-40a4-9e47-a343-fd5f6054a6fe@inria.fr>
 <033af1c6-e410-4ccb-8bed-41a308d66f1e@Spark>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <033af1c6-e410-4ccb-8bed-41a308d66f1e@Spark>
Subject: Re: [cocci] [HELP] Using macro `randomized_struct_fields_end` as
 context?
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2874
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/e9bc7027-5eba-461d-a659-4037849e3760%40inria.fr>

This is a multi-part message in MIME format.
--------------9cV0RbKYUzDqQttOydDE7br9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for all the information. You need two things:

1. A version of Coccinelle that has Julia's recent patch (b00c5adb1a48). 
It is available on GitLab, but not on Github, and you'd need to compile 
it yourself or wait until a new version is released. Let me know if you 
need help with that, it shouldn't be too time-consuming.

2. Remove the "depends" line. This script can work:

```
@@
field f : script:python () { f == "randomized_struct_fields_end" };
@@

struct task_struct {
...
+#ifdef CONFIG_KSU_SUSFS
+    u64 susfs_task_state;
+    u64 susfs_last_fake_mnt_id;
+#endif
f
...
};
```

(Maybe this was only necessary on my end, but I suggest you try that if 
it does not work.)

I can confirm that script with that version of Coccinelle works.

As for the original issue with the MacOS brew version, I unfortunately 
don't have reliable access to a MacOS machine to figure out the issue. 
Let me know if you'd like to spend some time troubleshooting that.

Victor

On 14/07/2025 20:00, devnoname120 wrote:
> Here is the information that you requested:
>
> ❯ paul@ubuntu:/Users/paul$ spatch --version
> spatch version 1.3 compiled with OCaml version 5.3.0
> Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc 
> --libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3 
> --enable-opt
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: Str
>
> ❯ paul@ubuntu:/Users/paul$ apt info coccinelle
> Package: coccinelle
> Version: 1.3.0.deb-1build2
> Priority: optional
> Section: universe/devel
> Origin: Ubuntu
> Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
> Original-Maintainer: Debian OCaml Maintainers 
> <debian-ocaml-maint@lists.debian.org>
> Bugs: https://bugs.launchpad.net/ubuntu/+filebug
> Installed-Size: 59.0 MB
> Depends: libparmap-ocaml, ocaml-findlib, libstdcompat-ocaml-iy6x7, 
> libstdlib-ocaml-fxjy5, python3:any, libc6 (>= 2.38), libzstd1 (>= 1.5.5)
> Suggests: coccinelle-doc, vim-addon-manager
> Homepage: http://coccinelle.lip6.fr
> Download-Size: 13.8 MB
> APT-Manual-Installed: yes
> APT-Sources: http://ports.ubuntu.com/ubuntu-ports plucky/universe 
> arm64 Packages
> Description: semantic patching tool for C
> Coccinelle is a program matching and transformation tool for C.
> The programmer describes the code to match and the transformation to
> perform as a semantic patch, which looks like a standard patch, but can
> transform multiple files at any number of code sites.
> Thank you,
> Paul
> On 13 Jul 2025 at 22:58 +0200, Julia Lawall <julia.lawall@inria.fr>, 
> wrote:
>
>
>     On Sun, 13 Jul 2025, devnoname120 wrote:
>
>         I just attempted to run this command on Ubuntu and although it
>         didn't return
>         any error, no change was done:
>
>         ❯ spatch --sp-file include/linux/sched.h.cocci --in-place
>         --linux-spacing
>         include/linux/sched.h
>         init_defs_builtins: /usr/lib/coccinelle/standard.h
>         SPECIAL NAMES: adding u64 as a type
>         HANDLING: include/linux/sched.h
>
>         Here is the content of `include/linux/sched.h.cocci`:
>
>         ```
>         @depends on file in "include/linux/sched.h" exists@
>         field f : script:python () { f ==
>         "randomized_struct_fields_end" };
>         @@
>
>         struct task_struct {
>         ...
>         +#ifdef CONFIG_KSU_SUSFS
>         +    u64 susfs_task_state;
>         +    u64 susfs_last_fake_mnt_id;
>         +#endif
>         f
>         ...
>         };
>         ```
>
>         The `include/linux/sched.h` file remains the same as before.
>
>
>     It all works fine for me. What version of Coccinelle do you have?
>
>     julia
>
>
>
>         Thank you,
>         Paul
>         On Jun 30, 2025 at 10:52 +0200, Julia Lawall
>         <julia.lawall@inria.fr>, wrote:
>         randomized_struct_fields_end will soon be supported in the C
>         parser. It
>         is not currently supported in the semantic patch parser, but you
>         can get
>         the same effect as illustrated by the example below.
>
>         I will let you know when this is all available on github.
>
>         julia
>
>
>         @@
>         field f : script:python () { f == "randomized_struct_fields_end"
>         };
>         @@
>
>         struct task_struct {
>         ...
>         + int something;
>         f
>         ...
>         };
>
>
--------------9cV0RbKYUzDqQttOydDE7br9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Thanks for all the information. You need two things:<br>
      <br>
      1. A version of Coccinelle that has Julia's recent patch
      (b00c5adb1a48). It is available on GitLab, but not on Github, and
      you'd need to compile it yourself or wait until a new version is
      released. Let me know if you need help with that, it shouldn't be
      too time-consuming.<br>
      <br>
      2. Remove the "depends" line. This script can work:<br>
      <br>
      ```<br>
      @@<br>
      field f : script:python () { f == "randomized_struct_fields_end"
      };<br>
      @@<br>
       <br>
      struct task_struct {<br>
      ...<br>
      +#ifdef CONFIG_KSU_SUSFS<br>
      +    u64 susfs_task_state;<br>
      +    u64 susfs_last_fake_mnt_id;<br>
      +#endif<br>
      f<br>
      ...<br>
      };<br>
      ```<br>
      <br>
      (Maybe this was only necessary on my end, but I suggest you try
      that if it does not work.)<br>
      <br>
      I can confirm that script with that version of Coccinelle works.<br>
      <br>
      As for the original issue with the MacOS brew version, I
      unfortunately don't have reliable access to a MacOS machine to
      figure out the issue. Let me know if you'd like to spend some time
      troubleshooting that.</p>
    <p>Victor<br>
    </p>
    <div class="moz-cite-prefix">On 14/07/2025 20:00, devnoname120
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:033af1c6-e410-4ccb-8bed-41a308d66f1e@Spark">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <title></title>
      <div name="messageBodySection">
        <div>Here is the information that you requested:</div>
      </div>
      <div name="messageSignatureSection"><br>
        <div>❯ paul@ubuntu:/Users/paul$ spatch --version<br>
          spatch version 1.3 compiled with OCaml version 5.3.0<br>
          Flags passed to the configure script: --prefix=/usr
          --sysconfdir=/etc --libdir=/usr/lib --enable-ocaml
          --enable-python --with-python=python3 --enable-opt<br>
          OCaml scripting support: yes<br>
          Python scripting support: yes<br>
          Syntax of regular expressions: Str</div>
        <div><br>
          ❯ paul@ubuntu:/Users/paul$ apt info coccinelle<br>
          Package: coccinelle<br>
          Version: 1.3.0.deb-1build2<br>
          Priority: optional<br>
          Section: universe/devel<br>
          Origin: Ubuntu<br>
          Maintainer: Ubuntu Developers &lt;<a
            href="mailto:ubuntu-devel-discuss@lists.ubuntu.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">ubuntu-devel-discuss@lists.ubuntu.com</a>&gt;<br>
          Original-Maintainer: Debian OCaml Maintainers &lt;<a
            href="mailto:debian-ocaml-maint@lists.debian.org"
            moz-do-not-send="true" class="moz-txt-link-freetext">debian-ocaml-maint@lists.debian.org</a>&gt;<br>
          Bugs: <a href="https://bugs.launchpad.net/ubuntu/+filebug"
            moz-do-not-send="true" class="moz-txt-link-freetext">https://bugs.launchpad.net/ubuntu/+filebug</a><br>
          Installed-Size: 59.0 MB<br>
          Depends: libparmap-ocaml, ocaml-findlib,
          libstdcompat-ocaml-iy6x7, libstdlib-ocaml-fxjy5, python3:any,
          libc6 (&gt;= 2.38), libzstd1 (&gt;= 1.5.5)<br>
          Suggests: coccinelle-doc, vim-addon-manager<br>
          Homepage: <a href="http://coccinelle.lip6.fr"
            moz-do-not-send="true" class="moz-txt-link-freetext">http://coccinelle.lip6.fr</a><br>
          Download-Size: 13.8 MB<br>
          APT-Manual-Installed: yes<br>
          APT-Sources: <a href="http://ports.ubuntu.com/ubuntu-ports"
            moz-do-not-send="true" class="moz-txt-link-freetext">http://ports.ubuntu.com/ubuntu-ports</a>
          plucky/universe arm64 Packages<br>
          Description: semantic patching tool for C<br>
          Coccinelle is a program matching and transformation tool for
          C.<br>
          The programmer describes the code to match and the
          transformation to<br>
          perform as a semantic patch, which looks like a standard
          patch, but can<br>
          transform multiple files at any number of code sites.</div>
        <div> </div>
        <div>Thank you,</div>
        <div>Paul</div>
        <div> </div>
      </div>
      <div name="messageReplySection">
        <div>On 13 Jul 2025 at 22:58 +0200, Julia Lawall &lt;<a
            href="mailto:julia.lawall@inria.fr" moz-do-not-send="true"
            class="moz-txt-link-freetext">julia.lawall@inria.fr</a>&gt;,
          wrote:<br>
           </div>
        <br>
        <br>
        <blockquote
style="margin: 5px 5px; padding-left: 10px; border-left-width: thin; border-left-style: solid; border-left-color: #1abc9c;">
          <div>On Sun, 13 Jul 2025, devnoname120 wrote:<br>
            <br>
             </div>
          <blockquote
style="border-left-width: thin; border-left-style: solid; border-left: thin solid #e67e22; margin: 5px; padding-left: 10px;">
            <div>I just attempted to run this command on Ubuntu and
              although it didn't return<br>
              any error, no change was done:<br>
               <br>
              ❯ spatch --sp-file include/linux/sched.h.cocci --in-place
              --linux-spacing<br>
              include/linux/sched.h<br>
              init_defs_builtins: /usr/lib/coccinelle/standard.h<br>
              SPECIAL NAMES: adding u64 as a type<br>
              HANDLING: include/linux/sched.h<br>
               <br>
              Here is the content of `include/linux/sched.h.cocci`:<br>
               <br>
              ```<br>
              @depends on file in "include/linux/sched.h" exists@<br>
              field f : script:python () { f ==
              "randomized_struct_fields_end" };<br>
              @@<br>
               <br>
              struct task_struct {<br>
              ...<br>
              +#ifdef CONFIG_KSU_SUSFS<br>
              +    u64 susfs_task_state;<br>
              +    u64 susfs_last_fake_mnt_id;<br>
              +#endif<br>
              f<br>
              ...<br>
              };<br>
              ```<br>
               <br>
              The `include/linux/sched.h` file remains the same as
              before.<br>
               </div>
          </blockquote>
          <div><br>
            It all works fine for me. What version of Coccinelle do you
            have?<br>
            <br>
            julia<br>
            <br>
             </div>
        </blockquote>
        <br>
        <br>
        <blockquote
style="margin: 5px 5px; padding-left: 10px; border-left-width: thin; border-left-style: solid; border-left-color: #1abc9c;">
          <blockquote
style="border-left-width: thin; border-left-style: solid; border-left: thin solid #e67e22; margin: 5px; padding-left: 10px;">
            <div>Thank you,<br>
              Paul<br>
              On Jun 30, 2025 at 10:52 +0200, Julia Lawall
              <a class="moz-txt-link-rfc2396E" href="mailto:julia.lawall@inria.fr">&lt;julia.lawall@inria.fr&gt;</a>, wrote:<br>
              randomized_struct_fields_end will soon be supported in the
              C<br>
              parser. It<br>
              is not currently supported in the semantic patch parser,
              but you<br>
              can get<br>
              the same effect as illustrated by the example below.<br>
              <br>
              I will let you know when this is all available on github.<br>
              <br>
              julia<br>
              <br>
              <br>
              @@<br>
              field f : script:python () { f ==
              "randomized_struct_fields_end"<br>
              };<br>
              @@<br>
              <br>
              struct task_struct {<br>
              ...<br>
              + int something;<br>
              f<br>
              ...<br>
              };<br>
              <br>
              <br>
               </div>
          </blockquote>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------9cV0RbKYUzDqQttOydDE7br9--
