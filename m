Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3732C4345F
	for <cocci@archiver.kernel.org>; Thu,  2 May 2024 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5lOKRxE80jZFROX5cJ9ObNrjqVOIbcI6PorP+alrS4g=;
  b=XM/rO9HryKcdzBmKiDiddTJ0tZqTMcXjkbK1VbdQ/aOVsnZFe3foyhbd
   m4OO/SWi/Urtq9IROT9d41JUE21qLMukt2GUq/sWk1puST45d7+aT41Rq
   PmoZWdNF+K90EBcgMDo6q7O9w5gxbSNLXvoi8z7kznEogyHnKeRwt/5ph
   s=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@redhat.com
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="164278873"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 May 2024 19:31:58 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 05D1DE0141; Thu,  2 May 2024 19:31:58 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3440DE0035
	for <cocci@sympa.inria.fr>; Thu,  2 May 2024 19:31:54 +0200 (CEST)
IronPort-SDR: 6633ce09_IPGDJHxsa1rePSrNGkcWXPLXeRTt0JVAy/Utynw/dH5jatc
 L44B4D8X870FkTkZuqzua9OYNQJ+jtZLgzn1vSw==
X-IPAS-Result: =?us-ascii?q?A0EHAABYzTNmh3yFCqpaFgQBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBPQMBAQEBCwGCQ3yBCgQLSIglhS2GSoIlmC+FW4FAPg8BA?=
 =?us-ascii?q?wELAQE9BwQBAQMBA4R/AoguAh4HAQQyBw4BAgQBAQEBAwIDAQEBAQEBCAEBB?=
 =?us-ascii?q?QEBAQIBAQIEBgECEAEBAQEiFwcOECeFcA2CZxEja2MCBgM3AQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQETAg1cAQEdAQEBAQIBEigGAQE3AQQLCxguFDQBEzWCX?=
 =?us-ascii?q?gGCQSMDEQapIgGMdQEBAXaBNIEBggwBAQaBCD4DCwJDTdsZCYFIAYgtAYlCe?=
 =?us-ascii?q?icVBoFJRIEVgyo+gVKBDwEBAoVzgi+aK4xJVH0cA1khAhEBVRMXCz4JFgIWA?=
 =?us-ascii?q?xsUBDAPCQsmAyoGNgISDAYGBlkgFgkEIwMIBAMQNAMgbxEDBBoECwd1gXyBN?=
 =?us-ascii?q?QQTR4E4iX0MgX2BNCmBTimEIUtshAuBeA5ig2GCMR1AAwttPTUUGwYiAaBsh?=
 =?us-ascii?q?G0Bsy6VAwcDhBOMDpUeBBYzhAWBVpFdDDmSNy6HWJBcjXSHTpMbAgoHF4FsA?=
 =?us-ascii?q?zCBXHAVgyIJCT0DGQ+OIBmDYYUUl19CNQIJMAIHCwEBAwmJIoFIAQE?=
IronPort-PHdr: A9a23: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
 7fSqwQjm+bFV9AzMC9yYw==
IronPort-Data: A9a23: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
 vRALZTz6IRp5X29AIGr9Dg=
IronPort-HdrOrdr: A9a23:OfLwYKM11rh7ocBcTuKjsMiBIKoaSvp037Dk7TETdfVwSL3lqy
 nOpoVn6faQsl0ssR4b9+xoVJPgfZqYz+8S3WBzB8bEYOCFghrMEGgK1+KLqVGOJ8S9zJ846U
 4KSdkdNDSfNzhHZIrBkXCF+3tK+rS6GCfCv5al85+4JjsaEJ2Jg2pCe36mLnE=
X-Talos-CUID: =?us-ascii?q?9a23=3AWNMaMGjkT2N2ZuXRciWdAJDlezJud2P0xUaXExa?=
 =?us-ascii?q?CBCUzabusGAbOwPtVqp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AkbYbrw0kzuR0ymrVA0K/oAoK8DUjx6meWHocuM0?=
 =?us-ascii?q?/vsCLby1BEieBhmydXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; 
   d="scan'208";a="86253652"
X-MGA-submission: =?us-ascii?q?MDHT9tKSq6XThrDjEyO82DB9Q+q0cgmrrOrPqr?=
 =?us-ascii?q?8Z3ifIAToRL2igsGbDnpr6qgE4YVDnlpyzogUqjThpffq60rGxhMhK86?=
 =?us-ascii?q?KbCWe8lyJUCE6NngnGc2XaC2+8NhAE/eB+nwHvbhx25YmZx7tPZybI16?=
 =?us-ascii?q?AT/4cdMT5kJq/vfi8Utrh4wQ=3D=3D?=
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 19:31:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714671110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5lOKRxE80jZFROX5cJ9ObNrjqVOIbcI6PorP+alrS4g=;
	b=RD/VJk5z/hy3Hofl/Ntlk+PrHo7PkbEKXGVjq0+hHUjw34ymYhlgTGGj8qyAJIiuP451wV
	NTOe94f4WPWyMeVF2bBD8dBvhedxJxjbXIO/cdDOX12yWgo20VZCRCDIXrJi0mATBvJgbf
	hrCDPNHvMaHcDO/uRrrdSpwLsTkIx+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-XIvS1nB-PkCKJDIlQI0WCg-1; Thu, 02 May 2024 13:31:49 -0400
X-MC-Unique: XIvS1nB-PkCKJDIlQI0WCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1FE2A03704;
	Thu,  2 May 2024 17:31:48 +0000 (UTC)
Received: from localhost (unknown [10.42.28.23])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9224BC13FA1;
	Thu,  2 May 2024 17:31:48 +0000 (UTC)
Date: Thu, 2 May 2024 18:31:48 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240502173148.GF30267@redhat.com>
References: <20240502085433.GA30267@redhat.com>
 <bf4ca7f1-d732-0fc-1991-f855c0364235@inria.fr>
 <20240502163131.GC30267@redhat.com>
 <6881602e-5f8e-db48-323d-139673441398@inria.fr>
 <20240502164958.GD30267@redhat.com>
 <20240502171930.GE30267@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20240502171930.GE30267@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [cocci] Very long compile times on
 parsing_cocci/parser_cocci_menhir.ml
Reply-To: "Richard W.M. Jones" <rjones@redhat.com>
X-Loop: cocci@inria.fr
X-Sequence: 1686
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/20240502173148.GF30267%40redhat.com>

On Thu, May 02, 2024 at 06:19:30PM +0100, Richard W.M. Jones wrote:
> FWIW this is the flamegraph.  It's not very informative, but maybe

... except that 86% of the entire time is taken in these two functions
(and stuff called from there):

https://github.com/ocaml/ocaml/blob/e202de7439afaec4671da56b59dce240447ea174/middle_end/flambda/invariant_params.ml#L99-L108

whatever that means.

> means a bit more to people familiar with the internals of the OCaml
> compiler.
> 
> http://oirase.annexia.org/2024-05-ocamlopt.svg

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW

