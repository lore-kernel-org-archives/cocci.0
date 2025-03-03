Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E03C282D0
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=3GVS4Gx/rVoQ468as/SRsaUG7WhV9vxUwVHJFy+CZ1g=;
  b=vZTXuK6LBs2r5D5vehUlS6GWbRxxKM0EBIJiJUTGvH9DfzSpn6IcMc9x
   ZhC+pyMdG96DRNRQB6y4XGmaPvFzd0plFzptUnVhT/K+M0pBEW6DD3ULD
   Yk1Tqq2eCMt+rsZWRZHIlRzYKuo2TJMD1jNpqWvoFEF0Mr5eCN609HaWl
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069468"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B4850E0D8D; Tue,  4 Mar 2025 10:58:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id AF763E0264
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 09:28:34 +0100 (CET)
IronPort-SDR: 67c56832_PoQTaYowH+7dWZ8kUP1a6G7JTk3vJ+A6EJcbdP9RFoelt0C
 PwpVmlWjUr5+NKO0EeZHfFjmD1B9AsDOoVYRloA==
X-IPAS-Result: =?us-ascii?q?A0G/AACJZ8VngTDQVdE9HRwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IFBBQEBCwGCQ31aMwRTkjOBcoF0MJ4UgX4PAQMBCwEBOwcCBAEBAwSBSwGDN?=
 =?us-ascii?q?AKLFQIeBwEEMgcOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABA?=
 =?us-ascii?q?SIZBw47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDQd3AQEBAxIVEwYBATcBD?=
 =?us-ascii?q?wsYLjMBBQEcBjWBYX8BgmQBAgcKoXqBBUKLPIEBM4EBggwBAQbcIIFlAwYJA?=
 =?us-ascii?q?QqBNAGFa4JjAYVShBZ6Jw+BVUSBFScLgkcxPosHgjOBaYM+gWyKUxwtgiWKW?=
 =?us-ascii?q?I5TUnscA1ksAVUTFwsHBWFISAOBDyMPgRQFNEE6ggtpSToCDQI1gh58gitqB?=
 =?us-ascii?q?AWBJII3hD2EQIVSghGBXQMDFg8Bgx93HIR8hGodQAIBC209NwkLG6IwO4RCg?=
 =?us-ascii?q?TmBGJQ1gz2OeqBYNAeEHoFdBgyKKZU1BhMvg3CTVQyTBZh9jgWbAgIKBwYRI?=
 =?us-ascii?q?4FLByyBXE0wgypPAxkPjiE4hCyEKcNSQDUCOgIHCwEBAwmFQyYTiiCBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U7Kq6CxD6x6F5DdVWbFez7kvEOsNc+2Iw==
IronPort-HdrOrdr: A9a23:x9gZZq23pNzVJ1+zp4882gqjBHckLtp133Aq2lEZdPWaSL3/qy
 mLpoVm6faUskdtZJhEo7q90ca7MBbhHPJOkO0s1PKZLXbbUQiTXftfBOnZskXd8kTFn4Y3pM
 VdmupFeabN5DBB/KXHCWKDYq8dKbe8gceVrNab4HF3UwlwZq1sqyt/AB2KC1B7SWB9aaYRJd
 6z4o5oqVObF0j/rf7VOpDGZYX+ThHw9a4OqCRnOyIa
X-Talos-CUID: 9a23:ceX6fW0AhQxOnaFBlGNT+rxfJPJ9Li2MnG3pDBW/GGtJceLIbF+W0fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AWZAz2AyKIsBfMa1Kjh6MnLEYE+CaqJajJH4Ng6w?=
 =?us-ascii?q?HgumjJSwzJ2+5sW67WZByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110461467"
X-MGA-submission: =?us-ascii?q?MDHndYeIAk2GYm2Ui3UPKFz7wYjWjuw9IlQdpc?=
 =?us-ascii?q?JMdg9+BBRiaEP5ASxF4gpC3J5bBimh8ThVeVvkjrVUfLlu8CgldP+vsO?=
 =?us-ascii?q?86ZgPjdakacng2lxrIlIVsoxT5OcHGVm14793Ouo114UuLKMBFhuzJJd?=
 =?us-ascii?q?BDqcilzamLsMsGb/en06/IFg=3D=3D?=
Received: from mail-ed1-f48.google.com ([209.85.208.48])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 09:28:35 +0100
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e51e3274f1so3193000a12.0
        for <cocci@inria.fr>; Mon, 03 Mar 2025 00:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740990513; x=1741595313; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3GVS4Gx/rVoQ468as/SRsaUG7WhV9vxUwVHJFy+CZ1g=;
        b=A9/3/aUMvNa9jphj38qjr73FojT1fV3tPPpUKikmwtOiAqBj/Ua3l0hTYsz2ar9KSk
         /7A72pcZsXtx82gn67QVmguSmtwRimBADtF/F5c6881nXjujbQqaHMYJX1weM3GFIN5X
         pKDJ4axlMJZdmISkvg0ab/p5Vbds9Up/d2NX11BDvrwqCayyoExD2q5HSjVPsjSbjv82
         5Asb6ZCYrVXGxfAeeS3jpjXVyFOi3Yuvs1bq84ZFAIlL+kmuLdWZwfSpo+WR4F+XPGjb
         BdJFmXjuwTBtIuvTvDyFlYvclm51N8nikQCj9QmDQzMHXo1qoIakWPs3fAAlwe82hQGN
         7tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740990513; x=1741595313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GVS4Gx/rVoQ468as/SRsaUG7WhV9vxUwVHJFy+CZ1g=;
        b=CfqTKs1SaQVmfla1dUg9h5fGRoNfwBK7Qlgc3RAI78VBcAAOb9TFHs5wA8mwJmidTV
         jqL6ge+x9aRHQmljwSxGl3580sRwmRMBnhbMsu4oLbTEfqVDtOfzPN3IoRDfjO492BFV
         MFeawitzo9x4V4bBry5Ynv6O6TULnafzy3oZcnrc1HPb/ByzWOBGqhwQC0LyDl7X56dT
         6/PRqpPCdAdpxbLVQ1851vjEi9FlS1L5uZTqOLGS/qZiUI7v3Re/uJ36plXV6ZdJ1Dto
         nONJz0LYHfsmzxqU3g/86j7djv5h3xF5MeN8zdiXtqRyXgtEs5kuNG5BkKuDolLT49pN
         RiFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW859dDqUGm3OfEbOFml2L3I3ZwjLtJn/WY/VVQbSNuazL0YI3BQjnPqLZafaP8a8bYOQa+gQ==@inria.fr
X-Gm-Message-State: AOJu0YzTYPDXIy+3k+Jmdoxub71TDNDUZmZafTeNNESmTqNLebHKwsRt
	Fg6eSBHv/bUkq6r8TR15jPol1q5v7EY6OfiLxTYj77KFIcCL+aeFLE74A3WylGI=
X-Gm-Gg: ASbGncvi22cg8WvZqSJvtVgmlP6j33uyZ4y1GXk4akbny8IG2GcdEnOBLu6oGi8H92Y
	0PjY3GL+KZCapkZIdju5HKDcbTNqHAnMx54EVx9tDKGO1oKxSt5d+RLvGZK3NY2C2wKW8kbtOee
	SSFYZscfVlHdU9cxvw9u8cYeZ++fXKZFGviRH3/iYbtiHajmewO+LmH8upP4GJj9B8lIftiKtsH
	fKLfbtLi1aZsiz+6Cl1W6UVbz/FaPaNZHKKLgNAgEVjEUjnN9SCTteNv069frQLunYyZGxuIIKY
	Q2rK24KNEdoQXd+2sNYL+Di0FrYsVg6uOnEl+nUq2ET0HzVzoA==
X-Google-Smtp-Source: AGHT+IGw3jWZzmT57/dnLc4o23VsN9vptXaHinStqoaL1K9VwYGdN1PlwZ1rxWVXdJbPl66BSv46Bw==
X-Received: by 2002:a17:906:135b:b0:abf:3fb0:8c01 with SMTP id a640c23a62f3a-abf3fb08ef3mr1023217366b.6.1740990513299;
        Mon, 03 Mar 2025 00:28:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf7a3ea634sm145845666b.174.2025.03.03.00.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:28:32 -0800 (PST)
Date: Mon, 3 Mar 2025 11:28:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ariel Elior <aelior@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ram Amrani <Ram.Amrani@caviumnetworks.com>,
	Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
 <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
 <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [RESEND] qed: Move a variable assignment behind a null
 pointer check in two functions
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2506
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/a191bd33-6c59-45c2-9890-265ec182b39a%40stanley.mountain>

On Mon, Mar 03, 2025 at 09:22:58AM +0100, Markus Elfring wrote:
> > The assignment:
> >
> > 	p_rx = &p_ll2_conn->rx_queue;
> >
> > does not dereference "p_ll2_conn".  It just does pointer math.  So the
> > original code works fine.
> 
> Is there a need to clarify affected implementation details any more?
> https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+null+pointers

This is not a NULL dereference.  It's just pointer math.

regards,
dan carpenter

