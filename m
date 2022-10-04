Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1316C433F5
	for <cocci@archiver.kernel.org>; Tue,  4 Oct 2022 10:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=ywKULUVMiSCFrhhZXLVBZMl1fOX+DAgEueVc8LpQ8XE=;
  b=Sico3pM4CQNbSHJo4qkG8maceoT16Tf5UYoraS/pILNholSomzEJtav9
   tZkR3G6Xt1inFTsud/uptRdmbf59pdJCJ3+CTiwQ8279aUF+S5ZaKFwzB
   sGtlFhduQJck9x03nqgoLepcDcJqzpJea29fM8ly5ET4ZfR3seoPNzqUt
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linbit-com.20210112.gappssmtp.com
X-IronPort-AV: E=Sophos;i="5.93,367,1654552800"; 
   d="scan'208";a="55873591"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Oct 2022 12:21:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2ABDEE0290; Tue,  4 Oct 2022 12:21:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 54C21E0076
	for <cocci@sympa.inria.fr>; Tue,  4 Oct 2022 12:21:04 +0200 (CEST)
IronPort-SDR: 633c090f_J8NgzHKK2Sneo1q/cN5TCFIxuqt/uej4LEpGmHx7Y5tkS9h
 jyyD/FwBfDA9vUvPu/aYrCmofcb4NJJVtGPwdqA==
X-IPAS-Result: =?us-ascii?q?A0ATCQDrBzxjfzTaVdFUBh0BATwBBQUBAgEJARWBUYE6A?=
 =?us-ascii?q?maBVy4EUIROkGeEWZoRA1QLAQMBDAESMAQBAYISgnOEbwIdBwEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEYCRkHDg4FJIVoDYI1IoQEE?=
 =?us-ascii?q?Q8BDQEBODQCJgI2AQUBLwgBAR6CW4MhAwScaIEEQosygTKBAYIIAQEGgmGDa?=
 =?us-ascii?q?oEeCQkBCH8qAgEBjy6BIYIpgTyHbwYlOIMJgmaZbyYEDgMZKx1BAgELdhgDF?=
 =?us-ascii?q?AMFIQcDGQ8jDQ0EHQwDAwUlAwICGwcCAgMCBhMFAgJNNAgECAQrJA8FAgcvB?=
 =?us-ascii?q?QQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHExgbGQEFWQ4JIRwKHg0FBhMDI?=
 =?us-ascii?q?G8FCjgPKC9pEBsdGwqBDCooFQMEBAMCBhMDAyICECoxFAQpExItBytzCQIDI?=
 =?us-ascii?q?msDAwQoLAMJIR8HKCQ8B1g/AwIQIj0GAwkDAiITRnYCMREVBQMNGSYIBTocB?=
 =?us-ascii?q?Ag8AgUGVBMCChIDEw8tSg+caINari6TKQeDYAWgHwYPBC6DZJMEFJIKLZZgp?=
 =?us-ascii?q?0ICCgcGECOBVSOBW3CDN04DGQ+OLBaDUIpgPzQCOQIGAQoBAQMJgjqFOIJHA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 TYyiw10YPhr/zDpsQ5fGw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:nMqKCaPlxAmQV8BcTh+jsMiBIKoaSvp037BL7TELdfQ2Gvb1qy
 nKppsmPHDP+VUssR0b6LK90ey7MBThHP1OkPEs1NWZLW3bUQKTRekIh+aCowEIWReOkNK1vp
 0QCpSWfeeAcmSS+vyKnDVQfexQpeVviJrY+Ns2mE0dNz1CWuVYyzY8MB+SFiRNNXd77EUCeq
 ah2g==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,367,1654552800"; 
   d="scan'208";a="25418076"
X-MGA-submission: =?us-ascii?q?MDHBYPeZ7CIZIE/Mde99zEp/jrMdu5fjKRPG5u?=
 =?us-ascii?q?lCeB6VpRN5wEs+5E6Tm7bdAJq7teqyW141l/badrhNUUCgYog6ycp+rA?=
 =?us-ascii?q?SR9rwkBTDNh4/+dmIUWjnJyTATYIdp9fCMAxTF74TofuEj0vypecNx8a?=
 =?us-ascii?q?7Vu91JSmUipUR/OZpDs6DYdw=3D=3D?=
Received: from mail-ej1-f52.google.com ([209.85.218.52])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 12:21:03 +0200
Received: by mail-ej1-f52.google.com with SMTP id z23so11092555ejw.12
        for <cocci@inria.fr>; Tue, 04 Oct 2022 03:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=ywKULUVMiSCFrhhZXLVBZMl1fOX+DAgEueVc8LpQ8XE=;
        b=wEjZhfo+64sbTs1BCcoYAEbW1nIGwZ+zI1RJEjULciVOLkNtsyD5Iym+5LFq4iOE1b
         3sFyOPKoymijiNqsp0gjfQxeHAxl3/hz1xB9zwvy5AidFMn4A8XN/7oo6mKMmt3ZmkSD
         DJuHvxhF9xvzwRFI39c7b6OvczlFnpZNmgQJi0IB6UlOZhab1fJBeFZ8HKB1NvB/0bNr
         6M1PezchiUi553TDOrYiEH5cAaNw4NNo7bXIFYxbGmzrCUp0uZiDJocDpIFVifZkIfAq
         aIX10HAMp2iAiFYQOlYXgl4iZ5ALAA+eT8fVjUdZBGoFLkx9Hm84hA+BID9whRgH8SCn
         ikGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=ywKULUVMiSCFrhhZXLVBZMl1fOX+DAgEueVc8LpQ8XE=;
        b=5tgrtmTmySghf1xUbrleweYref7PgVhV8lSLDkmAGBEb8h/Q6W73+IxVoWfutQ97UM
         YNXCPRn5oNorKDs2WpLS+eK0bn8mw3b45hl6ORq00099As6gh6/rI2hkxQIU8jElK5mw
         fPeri/K/Sr3XOGgse889qB1uEp6MbRdNqE3hJ6GLdUppRFXIkxmaC1ZCmBuApbvRn6XG
         wLCgdrIbdaiHiYOaRl05PEkRTLmaWwBNs1dokG6SZb+54nYAdF11pdCLupH5YAXZTJuZ
         S+EWXxd9Lbr0DBAjNqVUNR2u5ZmR8yIdArnOJ8MlTY1vGHBO+2QvDHHK5kIFB5iwmo3Q
         mS7A==
X-Gm-Message-State: ACrzQf3ldAT+iK8CNA9tcsd8OjmBd2TBZ7cgcIBXxRYChDg8KD3U1jYW
	XOzCT9X5NvMRqx7tPHTWs1XIXQ9WsBfyUA==
X-Google-Smtp-Source: AMsMyM6Z3UliHeNDVeRRdeyWoFW5rfLqEoNBmZPvVDL2q6Gh6k783WJw2WGihORTsvpyslIpIbSoyA==
X-Received: by 2002:a17:907:5ce:b0:730:bae0:deb with SMTP id wg14-20020a17090705ce00b00730bae00debmr19055285ejb.181.1664878862698;
        Tue, 04 Oct 2022 03:21:02 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090618a900b0077b2b0563f4sm6922722ejf.173.2022.10.04.03.21.02
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 03:21:02 -0700 (PDT)
Message-ID: <b5d97968-b1c6-191d-e4c0-662416e8bb90@linbit.com>
Date: Tue, 4 Oct 2022 12:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To: cocci@inria.fr
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [cocci] Matching against struct_group()
Reply-To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
X-Loop: cocci@inria.fr
X-Sequence: 613
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/b5d97968-b1c6-191d-e4c0-662416e8bb90%40linbit.com>

Hi all,

say I would like to replace an instance of the struct_group macro in the
Linux kernel:

	struct_group(algs,
		char verify_alg[SHARED_SECRET_MAX];
		char csums_alg[SHARED_SECRET_MAX];
	);

I'm guessing this is not supported by coccinelle because of the
"unusual" syntax? I tried specifying struct_group as a "declarer", but
that did not work (which does not surprise me because it's not really a
declarer anyway).

Is there any way I can still make this match?

Thanks.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
