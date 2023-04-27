Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE02C77B60
	for <cocci@archiver.kernel.org>; Fri, 28 Apr 2023 08:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:from:to:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wu6rKPpCmZBhRoKBmf6ihxrV74SRmnb8CZxGG9feTWs=;
  b=ZEb8p+YBmZOobvW2699DEBj2/RQeLoRUKDgIqoPoceeaFDnXKgpt6Pu2
   g8bxPAKJsaXAtt2ArNUt1A9z6RkZpYzrgsLV08pVi++F7+IUsZnoNVn/5
   99CvQY5j0nv7jhFS4Bd3s65czx6jlEQNXU/jFXQKDrpQwzO9CtSHmUZjc
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.99,234,1677538800"; 
   d="scan'208";a="105369546"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Apr 2023 10:15:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D6A6BE0D49; Fri, 28 Apr 2023 10:15:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A402EE0094
	for <cocci@sympa.inria.fr>; Thu, 27 Apr 2023 22:50:39 +0200 (CEST)
IronPort-SDR: 644ae01f_mfogLw2GMzCTLkkA9rrZGpj+FxsQ6sR3+g8otWSbwbz+laG
 X62PtPltozmBxND7QZVmRqJ8fxUWGoDgWcnomgg==
X-IPAS-Result: =?us-ascii?q?A0E2AAAn30pkf6/WVdFaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUskCwRRjHBfpEGBVoF+DwEDAQwBRAQBAQMEikACHQcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEZCRkHDg4FJIVoDYI3In2BC?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEWAg2BEBUTBgEBOE5GAQUBFkGFOQOlBYEEQ?=
 =?us-ascii?q?osxgQEzgQGCCAEBBp1OgV4JCQEIgS8Bh1IeXIgKgSEbgUlEgRU2iESDQYI0l?=
 =?us-ascii?q?i5pgTNygSeBMYEEAgkCEWuBEAhlgXRAAg1kCw5ugUWDFwQCFEIMF14EgRAGC?=
 =?us-ascii?q?Bo3A0QdBjoDC3U9NRQfglMEggJQmQx8E5Vtjl6CGotJlD+ECIFZDIhrljY0l?=
 =?us-ascii?q?wqSOZd6ol8ThQYCCgcGECOBQDqBXDMaCCgIgyJPAxkPjiCJBosFITQ9AgcLA?=
 =?us-ascii?q?QEDCYtFAQE?=
IronPort-PHdr: A9a23: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
 57Ijq2hcF9/
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gKPznKPqkYp9ocBcThyjsMiBIKoaSvp037AO7TELdfU1SL3hqy
 nKpp4mPHDP+VMssR0b6LS90cq7MArhHPxOkOos1N6ZNWGM2FdARLsC0WKI+UyHJ8SRzJ876U
 6iScRD4R/LYGRSvILV5g+3Ftpl5sKG/qCujeKb63t2VwllZ+VBwm5Ce2Sm+4FNKzWuzKBWKK
 ah
X-Talos-CUID: 9a23:8nr+c20YZOi5VPHz4JG62bxfGJ8KV0/57EvsYE6zNEUxWb7PUWOx5/Yx
X-Talos-MUID: 9a23:w2R/3QQ2td4P+s14RXSxihpDLPtByp6JEVJQo4QWp9K0EXxJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,232,1677538800"; 
   d="scan'208";a="105299912"
X-MGA-submission: =?us-ascii?q?MDGtjOqB7L/4jmlZNAvtFWC4MLoy6DQbUem9n6?=
 =?us-ascii?q?gOLOsRJOBaewKUPx2nriNSXJF3pWoSeW1q3clMGNn1azcPPFC85u3T6d?=
 =?us-ascii?q?fMuUy9+IThb21eK4/HTFcl4jRzMsPi1VQskfFDtbY0+swraB2y+GUWrA?=
 =?us-ascii?q?iECpQSUTYfEsCZCLVzvE3DPQ=3D=3D?=
Received: from mail-pl1-f175.google.com ([209.85.214.175])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 22:50:38 +0200
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1a6c5acf6ccso67771045ad.3
        for <cocci@inria.fr>; Thu, 27 Apr 2023 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682628636; x=1685220636;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wu6rKPpCmZBhRoKBmf6ihxrV74SRmnb8CZxGG9feTWs=;
        b=EGDU2oF7GRpqPJwKzJ7wY1PHgR91v6V0xNCsRNWYQ/CASjU0KybF/6Y+HR1GhF5wnF
         7hKTbUmWKXKe8C/jTNRpI7Auwzd68wBlUdro0nuNIcHdw3ruzu7DSok6aDs2EfY4+KN3
         qFTrp+qrrlbK6sxuWhdo4AY6lziI76yyVIA84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628636; x=1685220636;
        h=content-disposition:mime-version:subject:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wu6rKPpCmZBhRoKBmf6ihxrV74SRmnb8CZxGG9feTWs=;
        b=aBBj6E/CELjrLJ40d0sOMXmrUZx9b3MKsuGfFbqYC+n3l0dSPLdT34S/hnGWWeCuP1
         +XNoI6RUXNpbpKHCri+tHYkG7QXeNxFtYDYNnHz6DBr27e0cdeZUjgwdTDBb4rGV4dDe
         4PHzX3x7q1360+RKw56iYmgxm0lv7SiRvXWtTRePu/DbqtyKNDz7L+YOGAz8s0db5U5O
         T4iKO4Y/ml6CTxu+0XnKFz12PuTEzQ1Q3TgZAcKpo4KfiNNMOfikHgM2H9JRrvh1sf9t
         b1JUSxwU9eM7akDv7iMzwTIbdquexs50UMXvmA4j2robF1U5moqQLA9205mDiChQFyEd
         TAHQ==
X-Gm-Message-State: AC+VfDywDDwWCPuzJxEuyVL9OukAXN/nzFqWNRtq5h084UGeBuQNTZqK
	FpHWPXocM6OW20O38ewyvKc6C3G8MvCriSEJMLQ=
X-Google-Smtp-Source: ACHHUZ5P+cgiz+CKSZ1A5heTMi7yLvIcwhaCR20a1kc57TRyxKUjM8MDiPeUuWbiXsbxRUIiQtXaXQ==
X-Received: by 2002:a17:903:80f:b0:1a7:c058:a167 with SMTP id kr15-20020a170903080f00b001a7c058a167mr2152758plb.25.1682628636496;
        Thu, 27 Apr 2023 13:50:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902864900b001a800e03cf9sm11967351plt.256.2023.04.27.13.50.36
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:50:36 -0700 (PDT)
Message-ID: <644ae01c.170a0220.77675.8ed2@mx.google.com>
X-Google-Original-Message-ID: <202304271344.@keescook>
Date: Thu, 27 Apr 2023 13:50:35 -0700
From: Kees Cook <keescook@chromium.org>
To: cocci@inria.fr
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] metavariables in added attribute arguments
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 1133
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/644ae01c.170a0220.77675.8ed2%40mx.google.com>

Hello,

I am trying to annotate structures with a new attribute that identifies
which struct member contains the count of elements for a given flexible
array member:

struct foo {
	...
	size_t element_count;
	...
	int element_array[];
};

becomes:

struct foo {
	...
	size_t element_count;
	...
	int element_array[] __counted_by(element_count);
};

From the grammar doc, I found this note: "Attribute metavariables are
only allowed in context or minus code, and not in added code". I would
expect that to only apply to the name of the attribute itself, but
that's not what I'm trying to do. Here is the .cocci file:

// Options: --include-headers

@allocated@
identifier STRUCT, ARRAY, COUNTER, CALC;
expression COUNT;
struct STRUCT *PTR;
identifier ALLOC =~ "(devm_)?[kv][cvzm]alloc";
@@

(
        CALC = struct_size(PTR, ARRAY, COUNT);
        ...
        PTR = ALLOC(..., CALC, ...);
|
        PTR = ALLOC(..., struct_size(PTR, ARRAY, COUNT), ...);
)
        ...
        PTR->COUNTER = COUNT;

@annotate@
type COUNTER_TYPE, ARRAY_TYPE;
identifier allocated.STRUCT;
identifier allocated.ARRAY;
identifier allocated.COUNTER;
attribute name __counted_by;
@@

 struct STRUCT {
        ...
        COUNTER_TYPE COUNTER;
        ...
        ARRAY_TYPE ARRAY[]
+       __counted_by(COUNTER)
        ;
 };

This fails like so:

$ cocci element_count.cocci net/packet/af_packet.c
plus: parse error: 
  File "element_count.cocci", line 33, column 15, charpos = 593
  around = 'COUNTER',
  whole content = +     __counted_by(COUNTER)

But I can produce (nonsense) output if I change the replacement to:

	ARRAY_TYPE ARRAY[
+	COUNTER
	]
+	__counted_by
	;

Explicitly using "attribute name __counted_by;" didn't seem to help.
What am I missing?

Thanks!

-Kees

-- 
Kees Cook
