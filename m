Return-Path: <SRS0=9ZHZ=SC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A01C43381
	for <cocci@archiver.kernel.org>; Sun, 31 Mar 2019 17:42:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0076E20870
	for <cocci@archiver.kernel.org>; Sun, 31 Mar 2019 17:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSqM5ucg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0076E20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2VHgYDq025213
          ; Sun, 31 Mar 2019 19:42:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 030E37663;
	Sun, 31 Mar 2019 19:42:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 15A667631
 for <cocci@systeme.lip6.fr>; Sun, 31 Mar 2019 19:42:32 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:530] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2VHgUPD021448
 for <cocci@systeme.lip6.fr>; Sun, 31 Mar 2019 19:42:30 +0200 (CEST)
X-pt: isis.lip6.fr
Received: by mail-pg1-x530.google.com with SMTP id g8so3561850pgf.2
 for <cocci@systeme.lip6.fr>; Sun, 31 Mar 2019 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XMm3k+cgxwZdIaRUNy5U4qZUpke0q5GmXO4UUoNY7o4=;
 b=kSqM5ucgusZ2wNiAF3whIJLg9S7SeEoUvDg6SsXn3u28devOo/NeYDIMg35vhvP8TF
 NKlk+e2Elg86VS3JkYLh5osXp5SlgG3f3OTuWMfZP0sstwOme8Wmqysq9IRx3jfpf+ex
 5W16c8wgWPniP1JOVPz0TNR0hiFvyVLJYUjlD2F+TEZKchTJPs1yey0TIx7NVAX81yfY
 wnrCPXPPgHEQK2icjj5aATX/fdX2bFkGTqIIsYdbJQm2LgETYe9YIHwGDE1vp9WWKyyU
 b5zPBMsWMyEsZ4doGKYFJWGvSDfx3CI/O76QlVuLkKcR0u2o5W76EwuTTUaFEl2B+NyR
 N5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=XMm3k+cgxwZdIaRUNy5U4qZUpke0q5GmXO4UUoNY7o4=;
 b=m5/s7eI3qw4iLn7INKTdmVy5X6Zx+9x2PpZ+5OCmW+tNFMMoY1MqE0wVk25RFP1uvK
 XT2dNH1CzMITiPwwRTuFOvb0fBiVKJSQFi0YPsufAiG9/qoyFTxU04ygSVA6K1t5K8Ro
 r7IdpbHIr3EJ1Q6CuVwQF59cBme7px1KS0TfhXRR85ANk7xvHcYEmIgklnBnoZms2Nti
 KBLCShSDOMQVytWEbugNhWPnM5YOO3vH7368i1ZZmHZ8RNtHuDYjGwvj5ncBa3UHPQKT
 AnCCFXLYyNtJaDOnUcNxluCBsVLVBDDFKbpJDzj4/WGn+pM9lrXhhNp12UP4wyVeJT4l
 O0aA==
X-Gm-Message-State: APjAAAURVwGWgrxd4EU2r25hO1GO2e8hGVSHCDls7/8bLdzyBO4DriVU
 LEWv8XD+6W3mLqs3g/HM4bE=
X-Google-Smtp-Source: APXvYqxy0hR9jUn7jx1nRaWelCVFR9mw0L/KfuZGRlU3cT7yXy/QUvYtDKDII8r2gyvFwJP2yw8/bQ==
X-Received: by 2002:a63:c54a:: with SMTP id g10mr34810085pgd.71.1554054149814; 
 Sun, 31 Mar 2019 10:42:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 17sm7061341pfw.65.2019.03.31.10.42.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 31 Mar 2019 10:42:28 -0700 (PDT)
Date: Sun, 31 Mar 2019 10:42:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <20190331174227.GA27479@roeck-us.net>
References: <20190330222410.GA27158@roeck-us.net>
 <alpine.DEB.2.21.1903310950160.2578@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903310950160.2578@hadrien>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 31 Mar 2019 19:42:35 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 31 Mar 2019 19:42:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] A complex set of rules: can it be done ?
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

Hi Julia,

On Sun, Mar 31, 2019 at 09:58:15AM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 30 Mar 2019, Guenter Roeck wrote:
> 
> > Hi Coccinelle experts,
> >
> > is it possible to define a set of rules to automate the conversion done
> > in the attached patch ? I tried doing it myself, but did'nt get anywhere.
> 
> @r@
> initializer list elements;
> identifier i;
> @@
> 
> -static const u32 i[] = {
> -  elements,
> -  0
> -};
> 
> @s@
> identifier r.i,j,ty;
> @@
> 
> -static const struct hwmon_channel_info j = {
> -       .type = ty,
> -       .config = i,
> -};
> 
> @script:ocaml t@
> ty << s.ty;
> elements << r.elements;
> shorter;
> elems;
> @@
> 
> shorter :=
>    make_ident (List.hd(List.rev (Str.split (Str.regexp "_") ty)));
> elems :=
>    make_ident
>     (String.concat ","
>      (List.map (fun x -> Printf.sprintf "\n\t\t\t   %s" x)
>        (Str.split (Str.regexp " , ") elements)))
> 
> @@
> identifier s.j,t.shorter;
> identifier t.elems;
> @@
> 
> - &j
> + HWMON_CHANNEL_INFO(shorter,elems)
> 
> --------------------------------------
> 
> Theer is some ugliness here.  The elements of the array are considered to
> be an initializer list, while the arguments to the macro have to be an
> expression list.  The script code related to elems and elements is to deal
> with that.
> 
> There is also script code to constuct the first argument of
> HWMON_CHANNEL_INFO from gthe name of the hwmon_channel_info structure.
> 
> You should be able to drop the static const stuff on the structures, if it
> is not appropriate in general.  It should still be removed when the whole
> structure is removed.
> 
I dropped the "static const". With that, the above catches all instances
in the upstream kernel.

> If you want to write some other script code that makes metavariables in
> this way and prefer to use python, there are examples in
> 
> demos/pythontococci.cocci (only for making identifiers)
> tests/python_mdecl.cocci  (for making identifiers and others)
> 

And I thought this might be super-complicated or just impossible.
You are just amazing. Thanks a lot for your help!

Guenter
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
