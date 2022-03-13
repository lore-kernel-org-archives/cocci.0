Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBF5C433EF
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 16:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=aWq5fs2i6J9EunQ0F45nsYdnoiksNYU456PMtSOW/8M=;
  b=WaETq7OCGvLEIPo5n27eKZN21hf7fcO2uDM9W2wJeHWaIM91NgoG2msL
   yQdZxQfzXIhYn0/7v08lxlxSZ0ljTtdXFA8UOdwhonFWj6q3QhBqMzy4P
   Kz4AVw7sSkHRjGUsdQqGLp4ybsI/+mKzVpTQAlrCSEH3vIcFIbyZFEmdf
   Q=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@infradead.org
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25867183"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 17:32:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 28EE9E006C; Sun, 13 Mar 2022 17:32:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B39C6E0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 17:32:01 +0100 (CET)
IronPort-SDR: PGqyz5Pq+jYTlLeq6dgCxx2EG5UyLgkQ4PBC4DVC7MYl8DD9GrWACvEEiYIgNvqlOd8/Mf2XcG
 3A//TwwiWELKrWam3RsABAjjOY2dMYkfEFaKfbwcLwLsDGCA4reNXu3VOXiWH7mki5sfy2S6Qd
 PPMmsoFepwpiQI3kUWiqQnFyZttWABs7N2P1GCCSkqkAsPJIKFkaj34QG04XzHaRlc20N3zBVJ
 x94xfcXg2WeLKTzc5IH+YWlYZ/6j12Hy8IuoRLptGf2o/+FuX201On+2e2C7icszSBe9Rc7V43
 5oLCBCP4SKsl4HFuZmaua3YG
X-IPAS-Result: =?us-ascii?q?A0ALAABVGy5imIXKicZaHQEBAQEJARIBBQUBQIFGCAELA?=
 =?us-ascii?q?YIngVQsBAtEhA6IbIcgCgaBPwaLIJE/ggcBAwENQQQBAYktAh0GBjAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEARMBAQEBAQEBAQkLCQcGDAUQD?=
 =?us-ascii?q?gVBX2SBT4F9BgQwDYI1IoNsAQU6BgEBNwEPAQoOChwSECwbBoMXgxeuQ4Ezg?=
 =?us-ascii?q?QGCCAEBBodiCYE8AYYTFEKHXiccfYEQgUuCRDA+ikSbPaIRnhODU6AeqDeWV?=
 =?us-ascii?q?6FDhTiBYYIVfQiDJE4BAgECAQwBAgIDAQIBAgkBAQKOHQwWiGSFaiQxOAIGC?=
 =?us-ascii?q?wEBAwmSZQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:2ls0i6hQfArnHfu6E/Ogh+L5X161aBYKZh0ujC45NGQN5FlHY01je
 htvCmiGM/eOZGage9tyat7g8h5V6sSHzdE2TwRr/n0yEn5jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq+JSEYAbNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Npln8PqSAdyIrf2mP0XbzxCMi5uOpdI5+qSSZS/mZT7I0zueXzpyfxiDUVwPIsW4O97DGhCs
 /sCJ1jhbDja1rLwmenkDLM03IJ6d5KD0IA34hmMyRncBvk8Rp7rQqPE/9ZU0T48wMdUEp4yY
 uJDNGoxM02fPXWjPH88Mq9uofuFvELgagdSo2rKm4E140fMmVkZPL/FaoGNIoPUHK25hH2wr
 WXN9GXRGQAfLNXZyDyf83vqiPWnoM/gcIgVEbex+v9uxlyVyHYaBBAfWR28u/bRZlOCt8x3A
 RNO+yp1sbII9FWhcvznfhKop0SKoUtJMzZPKNES5AaIw6vSxg+WAGkYUzJMAODKUudrHFTGM
 XfUw7vU6SxTXK69Ei3Cq+/Fxd+mEW1Ecj9YPH5soR4tuoG7+OkOYgTzosGP+ZNZb+EZ+xmvn
 FhmTwBk293/aPLnMY3mpDgrZBrx+vD0ovYdvFm/Y45cxloRiHSZT4Kp80PHyv1LMZyUSFKM1
 FBdxZTBtblVVszdzHzSKAnoIF1Pz6vcWNE7qQMzd6TNCxz0k5JeVdkKsGkWyLlBa5hslcDVj
 L/741gJvMANZRNGnIdyZIC2Q8In0bfnD9f+Ps04nfITCqWdgDSvpXk0DWbJhjiFuBF1wckXZ
 MnHGe7xUydyIfk3nVKeGrZGuZd2l39W7T2IH/jTkU/4uYdykVbIE9/pxnPUMLBghE5FyS2Im
 +ti2zyikEwODrehPnGJreb+7zkidBAGOHw/kOQPHsbrH+asMDhJ5yb5zexzdop7sb5Sk+uUr
 HixVlUBkwj+g3PdIAmHY3wlb6ngBM4toXU+NC0qHFCpx3lyOt7xsflPLcU6Les96ehu7f9oV
 P1ZKc+ONetCF2bc8DMHYJij8IE7LEa3hRiDNjaOaSQke8IyXBTA/9LpJ1O99CQHAietm9E5p
 rmsilHSTZYZHlwwD8vMbv+riVSrsiFFyu51WkLJJPhVeVntoNU1dHWp3qdvLphVexvZxzac2
 wKHOjsipLHA890v7d3EpaGYtIP1QeFwKUxXQjvA5rGsOCiGo2euzNMSUOuMejyBBmr49L/4P
 7dfyPT2OfEGmBBLtYRmGrpmxK544MHg/ucIwgNhFXTNTlKqFrIxeSHYgJcf7PNAlu1DpA+7e
 kOT4d0Ea7+HD8PSFlNMdhEuaf6O1K1JlzSOv+45Jl72uH1+8LadCx8ANR6JgiVRLb8zMYUr2
 +4ttccarQulhUNyYNqBiylV8UWKL2ABAv5/6MxEUNW1h1p50ExGbLzdFjTyvsOFZeJMBU8nf
 22Pj63YirUAm0fPfhLfz5QWMTaxUXjPhPxL8LPGD16On9DMiv4zmhxX/y4+QglcwlNAye0b1
 q2H8aFqDf3mwtuqrJErs6OQ98VpBRuX4EX9xlIF0mrDQCFEk4ALwHIVYY6wEYNwz46YVjld8
 quRxGvsXXDtZs6ZMu7en6J6g6SLcOGdPTEuVCxq8wpp0nX6jffYbneSWFc1
IronPort-HdrOrdr: A9a23:JioqWa9QpCzXqcs96IVuk+DbI+orL9Y04lQ7vn2ZhyY6TiW9rb
 HLoB17726QtN91YhodcL+7VZVoLUmxyXcx2/h3AV7AZniFhILLFuFfBOLZqlWLJ8S9zJ8/6U
 5OSdkZNDSaNzlHZKjBjzWFLw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25867176"
X-MGA-submission: =?us-ascii?q?MDH4EKbfGsdCw7/pLOU5cYJgA3hBxKWrQAJEKQ?=
 =?us-ascii?q?sqK5dngieE3t1g1V/YfeUurCCd+hfHxdSx9Uvc+Mvsnk4agNqBmSi2hy?=
 =?us-ascii?q?4cQ5ImY9zHNrT3J8XiZkQV9rxKXj+VOSGSDd0hVh91w+jGhckYEzNtjo?=
 =?us-ascii?q?DqjDeXIyfZzFycVZhkmuouvw=3D=3D?=
Received: from bombadil.infradead.org ([198.137.202.133])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 17:31:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aWq5fs2i6J9EunQ0F45nsYdnoiksNYU456PMtSOW/8M=; b=Jcig2o5iG4I8aT2SO1sVX1HMWy
	lq7mJqCHFoZptFHUYdgT1OhW5t9bQAWBt5dlDwbhn0dfO3ZROzXvs8NJQoLGcdCwoI4bwMuPwInrL
	0XkP08xVJrmCTzFkZZgmYRftSl9mn0UmykP6QUqclddH+gt8EdC2UBfTgACSKa/MpijsTYlJ2QyTj
	FeKPy5O9L1+Mn05Pe0pFAcw79DHT6Y8HUJax0Gw1lrxkBzHuNH4O3nKwaFc+eyY6uns8rki7kRZ1b
	TgFxEeMa6mQc0+gVXu4zsi9wsVtZNPmHidG8qQBwR80sC5HelZPYBSnRpdHex4oQlLSPcnJH/IEW6
	ndqiw6mg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTR8N-0039Yz-AK; Sun, 13 Mar 2022 16:31:55 +0000
Date: Sun, 13 Mar 2022 09:31:55 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: cocci@inria.fr
Message-ID: <Yi4ce+2k03795Rut@bombadil.infradead.org>
References: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net>
Sender: cocci-request@inria.fr
Subject: Re: [cocci] Can Coccinell concatinate or append to existing string
 literals?
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 219
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/Yi4ce%2B2k03795Rut%40bombadil.infradead.org>

On Sat, Mar 12, 2022 at 04:53:22PM -0800, Eric Wheeler wrote:
> Hello,
> 
> I would like to do something like this:
> 
> 	@ a @
> 	constant C;
> 	constant CN ## "_bar";
> 	@@
> 	-foo(C);
> 	+foo(CN);
> 
> to produce this:
> 
> 	void f()
> 	{
> 	-	foo("foo");
> 	+	foo("foo_bar");
> 	}
> 
> It looks like `fresh identifier` can do something like this, but I can't 
> get it to work with strings.  Is there a way?

Yes sure below is an example I used recently in Linux:

@c1@
expression E1;
identifier subdir, sysctls;
@@

static struct ctl_table subdir[] = {
    {
	    .procname = E1,
	    .maxlen = 0,
	    .mode = 0555,
	    .child = sysctls,
    },
    { }
};

@c2@
identifier c1.subdir;

expression E2;
identifier base;
@@

static struct ctl_table base[] = {
    {
	    .procname = E2,
	    .maxlen = 0,
	    .mode = 0555,
	    .child = subdir,
    },
    { }
};

@c3@
identifier c2.base;
identifier header;
@@

header = register_sysctl_table(base);

@r1 depends on c1 && c2 && c3@
expression c1.E1;
identifier c1.subdir, c1.sysctls;
@@

-static struct ctl_table subdir[] = {
-       {
-               .procname = E1,
-               .maxlen = 0,
-               .mode = 0555,
-               .child = sysctls,
-       },
-       { }
-};

@r2 depends on c1 && c2 && c3@
identifier c1.subdir;

expression c2.E2;
identifier c2.base;
@@
-static struct ctl_table base[] = {
-       {
-               .procname = E2,
-               .maxlen = 0,
-               .mode = 0555,
-               .child = subdir,
-       },
-       { }
-};

@initialize:python@
@@

def make_my_fresh_expression(s1, s2):
return '"' + s1.strip('"') + "/" + s2.strip('"') + '"'

@r3 depends on c1 && c2 && c3@
expression c1.E1;
identifier c1.sysctls;
expression c2.E2;
identifier c2.base;
identifier c3.header;
fresh identifier E3 = script:python(E2, E1) { make_my_fresh_expression(E2, E1) };
@@

header =
-register_sysctl_table(base);
+register_sysctl(E3, sysctls);
