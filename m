Return-Path: <SRS0=WLW8=OX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6E2C67839
	for <cocci@archiver.kernel.org>; Fri, 14 Dec 2018 08:11:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508CE2080F
	for <cocci@archiver.kernel.org>; Fri, 14 Dec 2018 08:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508CE2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBE8As5f008215
          ; Fri, 14 Dec 2018 09:10:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 61C4376D8;
	Fri, 14 Dec 2018 09:10:54 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A2B1F76D5
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 19:06:34 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBDI6VTv006394
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 19:06:32 +0100 (CET)
X-pt: isis.lip6.fr
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Dec 2018 10:06:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; d="scan'208";a="303602505"
Received: from irsmsx151.ger.corp.intel.com ([163.33.192.59])
 by fmsmga005.fm.intel.com with ESMTP; 13 Dec 2018 10:06:29 -0800
Received: from irsmsx110.ger.corp.intel.com ([169.254.15.233]) by
 IRSMSX151.ger.corp.intel.com ([169.254.4.32]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 18:06:29 +0000
From: "Flykt, Patrik" <patrik.flykt@intel.com>
To: "schwahn@cs.tu-darmstadt.de" <schwahn@cs.tu-darmstadt.de>,
        "himanshujha199640@gmail.com" <himanshujha199640@gmail.com>,
        "Ceolin, Flavio" <flavio.ceolin@intel.com>
Thread-Topic: [Cocci] Build issue after stdcompat upgrade
Thread-Index: AQHUkw6Ry3DFZ5nIu0mzMiteJclU0g==
Date: Thu, 13 Dec 2018 18:06:28 +0000
Message-ID: <d94f90c42069e3fca6075fcff761d5070012daea.camel@intel.com>
References: <ecaf70fe-1194-9457-ad0c-5f029343b2d4@cs.tu-darmstadt.de>
 <alpine.DEB.2.20.1812101554470.3486@hadrien>
 <9957435e-f4bc-92aa-0a9e-295c0d77345b@cs.tu-darmstadt.de>
 <20181210174227.GA2063@himanshu-Vostro-3559>
In-Reply-To: <20181210174227.GA2063@himanshu-Vostro-3559>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2-1 
x-originating-ip: [10.254.104.111]
Content-ID: <0E242BAC5207D74089F61C892E7072B6@intel.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Dec 2018 09:10:54 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 13 Dec 2018 19:06:32 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 14 Dec 2018 09:10:52 +0100
Cc: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Build issue after stdcompat upgrade
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

On Mon, 2018-12-10 at 23:12 +0530, Himanshu Jha wrote:
> On Mon, Dec 10, 2018 at 04:42:05PM +0100, Oliver Schwahn wrote:
> > > > Do you have any suggestion for a workaround?
> > > 
> > > Can you upgrade to 4.06?  I also have this problem with 4.05.
> > 
> > Thanks for the suggestion. OCaml 4.05 was indeed the problem. I
> > upgraded to 4.07 and that worked fine.
> > I also had the chance to check on configurations with OCaml 4.01.0
> > and 4.02.3, which also work as expected.
> 
> FYI Patrik & Flavio,
> 
> You too need to Upgrade and try again.
> 
> https://lore.kernel.org/cocci/ecaf70fe-1194-9457-ad0c-5f029343b2d4@cs.tu-darmstadt.de/

Debian testing with ocaml from stable, i.e. ocaml 4.02.3-9, stops with:

OCAMLOPT  parsing_c/ast_c.ml
OCAMLOPT  parsing_c/includes.ml
File "parsing_c/includes.ml", line 159, characters 9-22:
Error: Unbound module Parmap
make: *** [Makefile:424: parsing_c/includes.cmx] Error 2
rm parsing_cocci/parser_cocci_menhir.ml.d parsing_cocci/lexer_script.ml parsing_cocci/lexer_cocci.ml

Here Ubuntu OCaml seems to have a difference against Debian. Ocaml
4.05.0-10+b1 is unfortunately the latest in Debian testing and
unstable. It seems I have to sit and wait until also Debian gets
updated.

Cheers,

	Patrik

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
