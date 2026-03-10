Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AF31049521
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=nPEo3k2fwZhwgIqrsgLaFQDOcFNuCDzt1kvGP06H+Vs=;
  b=o/ZZ6FTzW5bWDtFYUTJz9RQp7jmzQdLCQY393OfjcjVIjmOaxKyPbxzz
   abaDL5yVW+QP8XOeXYBVl5tRDhDDY3PdB8VD3WkqXjkua+EsHQySULmZL
   qAHFuxJ/RIq7S8gKbgDnxEeP3Tl1Kp6u4ZosYcYwC4YRd4d7qyyKm9pIr
   Q=;
X-CSE-ConnectionGUID: XCQtPZO+QlKBd83MfJJs8Q==
X-CSE-MsgGUID: SAparHCCTOqgPP/Rxi0+tA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267245497"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:02 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1384D818CD; Wed, 11 Mar 2026 10:46:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3342A83AD4
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 19:13:28 +0100 (CET)
X-CSE-ConnectionGUID: kXbbyLYfQQqNpn/Evf/3Ew==
X-CSE-MsgGUID: JU2VYodCRjqNG0SY5ntMnQ==
IronPort-SDR: 69b05f3c_SVPXIB5z745Nyyzaprb9pZ5OXta2nVIqF6FMBP6BmZkHqmJ
 +kfMhjG2U6HajI3VUWMxtxMqin/jFHxC6ggD2ug==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0H0AQDEXrBpewGco5RAGh4BAQsSDECBRQuBblOCGQQLS?=
 =?us-ascii?q?YRYg0wDhSyIfItkkGGBVYFAPQIPAQMBCwEBUQQBAQMEhQACFo0NAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAEBQg47hk8Ng?=
 =?us-ascii?q?mIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAghjAR8BAQEDEhERD?=
 =?us-ascii?q?AEBNwEPAgEIGAICJgICAh4RFRACBAENBSKFChEDNgMBAp9UQ2cLARs2IwFIA?=
 =?us-ascii?q?lZCiREBAQF4gTKBAYIMAQEG2y8NglUJFAGBCi6DEIUlHwGBcIF3gXMaG4RfJ?=
 =?us-ascii?q?4IogRWDKj6BUk2COyODIYJpgiaBDokKihkJSXgcA1ksAVUTFwsHBWFCEDMDI?=
 =?us-ascii?q?AovLQIUDRASDwQWBS0dcAwnEg8dFxQfWBsHBRIhKoFJeIFmGw+GankDLl4aD?=
 =?us-ascii?q?iICKBIDMgQjSj4LWgWCSAMLbT03Bg4bBD2ObD6CMwEBgQ4bgiSTTwGDKkqaP?=
 =?us-ascii?q?5QmcQeEH5tchkmqay6HZZBzIpFwlwQCBAIEBQIQAQEGgWg6gVxNI4M3TwMZD?=
 =?us-ascii?q?44hDBaDXo89Abl6RTM8AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:wF6Iu6P4xT3GJ8BcTxT255DYdb4zR+YMi2TDiHoedfUFSKOlfp
 6V8MjzjSWE8gr4WBkb6LW90DHpewKXyXcH2/htAV7EZniqhILIFvAo0WKG+Vfd8kLFh4hgPM
 tbAstD4ZjLfCNHZKXBkUWF+rQbsaC6GcmT7I+0ohYMcegpUdAZ0+4TMHfFLqQCfnggOXNPLu
 v52iMonUvDRZyVBf7LXUUtbqzuttfLnJXpbVo8AQI76A6BtDWs6LTrORmV1BUTXlp0sPgf2F
 mAtza8yrSosvm9xBOZ/XTU9Y5qlNzozcYGLNCQi+AOQw+cyzqAVcBEYfmvrTo1qOag5BIBi9
 /XuSotOMx19jf4Yny1mx3wwAPtuQxeq0MKiGXowkcLk/aJAQ7SOPAxwb6xtSGprHbIiesMkp
 6jGVjp8aa/QymwxRgVrOK4Ky2C3nDE3kbK19RjwUB3YM8mc7lWopUY/ERJVLk9PA+S0vF7LM
 BeSPjG4vBYaFWbaG2cmFJO7piDYlQfdy32HnQqi4ityD5Rk2l+z0wEgPcSnnAC+JghIqM0v9
 gtFMxT5eBzZ/5TVLl6AugZR8uxFyj2WBrJdE+fPFzmEbtCF3XGwqSHuondINvaJqAg3d88no
 /MX0hfsnN3c0XyCdeW1JkO6RzVRn6hNA6dvP22SKIJyYEUaYCbRRFrcmpe5PeIsrEaGInWSv
 yzMJVZD7vqKnbvA59A20n7V4NJIXcTXcUJspJjMmj+6v7jO8nvrKjWYfzTLL3iHXItXX7+GG
 IKWHz2KN9b5k6mV3fkiFzaWm/reEb44ZVseZKqttQ72cwILMlBowIVgVO26oWCLiBDqLU/eA
 9kLLbugsqA1ByLFKbznhdU0zZmfzZoCe/bIg13TCcxQjLJTYo=
X-Talos-CUID: =?us-ascii?q?9a23=3AS+hrimhNViUpJf4I0O2x2KGsUzJucU3Xxmb0EkG?=
 =?us-ascii?q?BMH9PULvSZEGev/hJjJ87?=
X-Talos-MUID: 9a23:z/EA1Au7AbROyXwYu82npgw4CvZv74+UClkrvs09ipSCKQl2AmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267166207"
X-MGA-submission: =?us-ascii?q?MDEZw093UeKw5dNLijbeuzP/lgrS+pfk8lvzCj?=
 =?us-ascii?q?Iyo86r/gczjEQpCkDqpllB5gXYm796nb7Z4NEjcWreh7EttZlk/OjcBs?=
 =?us-ascii?q?xOK30YAvUgJh3L1Z5RBLJz7pVAtpognvuXQIiLlb2xQ91zIiqPUec7SQ?=
 =?us-ascii?q?IB5qbfLMHTsToyPnnUh/84MA=3D=3D?=
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 19:13:15 +0100
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9qCvs1433673;
	Tue, 10 Mar 2026 18:13:10 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuyc9g4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 18:13:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or7IekFNvA84bBHC15aisKosnAIWs70vTE0O4GD7ALXOJw6JOvdM4YvwcbUuVrRfwLR2VbQJEWfDAZEvKSW8f/t6ZhUS+ghE1dFMHEBIC5Tcmag7ImEXdhZ7LbHI/8qUGwuoEDPZVJa8vZgwOKWrHdrsW6Hd30Lq+8uI3oFL+MNBlvfycy/oYC7HdU4QdTnGvWq/Lkyvv/U0MPp9MidVIZtibuRdrTnGAZotf44yub8JlsCmrnETfZ4ndyOsUimiTfLufGRw5+wxfINYdapJxVPFwXvRsYjXd2C7M/QJbDLri61RcD7V+kzwBoE/30dct5thtxIR6iA2+f+NTwPpTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPEo3k2fwZhwgIqrsgLaFQDOcFNuCDzt1kvGP06H+Vs=;
 b=CGWUw4qwgY/FudQfdnhZNC6HwbVcYl+/rMmHKkw40fvSyf4w/p9BzE9kFyRCclJJ4Sxm4q3vpPxXiyVTkcJhj0+v7bzuncQIyvk8udJhXWGBPjvfbRqM4P2W6zUl/TaZZgchbKv2TX3nMaYskGNrv3KVMyLNEMviu7uIDvCFqg2UxHe6wCJPX4SJORNL9JxRl8vH+q0NzDPs46hEORCyMvlQtGmC0EaPBg0ea5NkU3aibfsBsmSSeLHv7i5QKkrDkVDfnMk0wP8ZKq20EcPaiBGvmd384xuC3Ui2WTqCz3wZ0Vo/YWrIc8/2sh2uaZN6/YskrrF7u8xtEBTz7t/RtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH5PR15MB6945.namprd15.prod.outlook.com (2603:10b6:610:2f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 18:13:03 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9700.009; Tue, 10 Mar 2026
 18:13:03 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
        "phahn-oss@avm.de"
	<phahn-oss@avm.de>,
        "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>,
        "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>,
        "linux-sctp@vger.kernel.org"
	<linux-sctp@vger.kernel.org>,
        "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>,
        "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>,
        "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>,
        "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>,
        "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>,
        "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "sched-ext@lists.linux.dev" <sched-ext@lists.linux.dev>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "v9fs@lists.linux.dev" <v9fs@lists.linux.dev>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>,
        "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>,
        "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org"
	<target-devel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>,
        "cocci@inria.fr" <cocci@inria.fr>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>,
        "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>,
        "linux-leds@vger.kernel.org"
	<linux-leds@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
        "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Thread-Topic: [EXTERNAL] [PATCH 03/61] ceph: Prefer IS_ERR_OR_NULL over manual
 NULL check
Thread-Index: AQHcsId8oNXR/FZQ2EuIyBsTGM+uMLWoEgIA
Date: Tue, 10 Mar 2026 18:13:03 +0000
Message-ID: <1464b1fb96df5dd085984ac70086417c4b7cfb77.camel@ibm.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	 <20260310-b4-is_err_or_null-v1-3-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-3-bd63b656022d@avm.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH5PR15MB6945:EE_
x-ms-office365-filtering-correlation-id: 18033782-9746-4e44-9816-08de7ed0abf7
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|18002099003|56012099003|22082099003|38070700021|921020;
x-microsoft-antispam-message-info:
 9LAe9FEFSN/vfSfiV5oqVZqpylENlWFi5RM+1C+1bDG44109Q6rTiNxosug6OQv/x6tkh5cOAar+HZNPI8BFM12KKS5lsJ3NGLrVlO20rSFB+jdQj6vSJYdmRBTqGeSk7Y/ombrAgdY3MA5Ccautt/cVbAKKVx1jhRWfOMSyT1CKFo7WLS/D/PvElWEONOQkdGwgQqqrYQOTplUYyJNVjErQTAFxACEOm5HY5EJOEQG1tvgurUHYAlmliMVw98Rk5Hgofogo+nX+QACpEY5he2lOVWKjyRLX0GSnMlWTP8G9IiiIiUanug554WDoMFtZVOzZXrNkvESXPjaSevtgOTXQcQOb0TNn8cJRHRwIYeCwjlIyfGh9m3Z1Umx4scOBXzyFzl9gLjbde9/SW1TkIABOGyFDuc5RA05kXkxaLRhegQBCBTdc5nN2wceNz88JjjhSNnjfvZzjUmjuBwUIJLEnf35VREfPs6aieiLroDKAiXT9qTxP1Oz7rR2l4/AWkUwRgp5Pv5h708JlxRKTT6yVHzN14nfhWFedrClZer7TdDN2qoXpUQ0dKki8BDQMS+biNGAsIVWyIR1+VWE9GgFUc1JfaNfHCn+m6N//yoBVvskxD8sqQ+1BWiFkunYzRuho7o9L118JV2Z8ratVms037j2+/ZBhORE2GBCFW9MOj2/vNDZ7WI2Vviyq+t8WMdVFAq21Eo1EybBoAjcAzsyLMGTD2OYXmESCcV68EEzeETd3U+VBmSkHDcQOFXypK/rMh0b5xn/QyWx2ZWqVnvxHjzN0mB7GqWzInRsHQXnEqAo3NHtf+SW1k4O+nVsZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(18002099003)(56012099003)(22082099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rm1qQ3FtMW1CeW84ZmlYMkhkT1ZEaDdjU2ZYUXZzMVk5RlR5MUEzYjFtdHdL?=
 =?utf-8?B?Z0EyNHlnUDErUFJXS1I1VUhSQ0lsQ0NrUmdZZnltSzhuTkFhZkx0bnAzeE14?=
 =?utf-8?B?K1RVWUdUUzM1NVgvZGx1WUFjKzVrL05uU0g5NEZzWDZueGRucEhLN3FqcG9S?=
 =?utf-8?B?RzlaN2huVWgzYVB5UXFQZnpEeCtEZUJZYjN3cmd2a3BnNlRYMWhpYWx0d3pl?=
 =?utf-8?B?aDVWU0hsamxaNkR3NGRMREdzd0VpRTdiT2svZ1UwQStTSzBXRkNFTCtBalFj?=
 =?utf-8?B?eTh4R01EcHB1NHovaTg0a2RPNnplRFdoN3UwT2ZXcElkVmIyQ1J5UTd2K0pT?=
 =?utf-8?B?ZFhDYktJNjJwb1VLRzY2eUt6b1ZqN1dvdVlyZFR2SmdaY1ltbXp1TTkwUmxa?=
 =?utf-8?B?QUNpKzFwaXB6WUlBTWU2SmU0WGdySE13RnY0SjB6QVNZR28wNTlPSzNSY2Vn?=
 =?utf-8?B?VTcvNjJzYVM2WnVRbGhaRkZEcEhTUWJsNlNhL090NUU1UHhhSG03Q1Ayc3U2?=
 =?utf-8?B?MjdTNlUyNjR1SWlOREQ3SjY2a3JlNDZPRVVySnBkWUhkbXAzRndMUEQ0Ritn?=
 =?utf-8?B?MXhKNXI1UTVYUkllN0JYT2dnNWhySDF4V1dTVzBVMFZWVFNMNGZOeTRJUXlE?=
 =?utf-8?B?WUxqNTN2ZHFycnU3V3V6NE5IZkl0OVQzYUJVZzFlMkpKUXlGZkNIUTZJUnBK?=
 =?utf-8?B?U0wzNDV6cERjdFYwcEJCZTlLbWpaZ2NoU2l6cUowN2dTcmVCbnlCUWp5RW8v?=
 =?utf-8?B?QWJya0kzWHRHTlJDWU9sSmVKeWJhcHJyKzBFMW5DVG5xVlRobk02SFZNV0lo?=
 =?utf-8?B?cjJrTklkeUc3Z2luWlNCR2hxa1hJdHcyM29nRkt6bktLdFBtWDB4RG5rMm9N?=
 =?utf-8?B?Sjk0UzRFSWhVY0pieXlHeGZMd0o1ZGpZRmdXNG13Q2xvK29WSnNsM0VxaFZ0?=
 =?utf-8?B?STV4VlV0TTRoMEZ0STJXdE9WU2xsV1dpQ0U2eDNrRXhYZzRXOVI0djhqTmZt?=
 =?utf-8?B?ejUxd09vWHVtUGdUSElvWHlMOXl3bGNKNUR1VEo3RFF1MlRUQ0xrbndGN0N4?=
 =?utf-8?B?ek9BTUR6SmhwRFh6c0piUFRWQi83RmtVV294N2R0czluUldvbHZBZTdlc0xp?=
 =?utf-8?B?eHBGMG9iVThMUUd2RXMyUUdpc3ppUFlWamhKSVBkR0tNMnk1aWVyVHpCdHhP?=
 =?utf-8?B?TUtjb3JMT3R4TjNkK3VSdm1tN0V6NmFFY2c3dWFxTU8wYlZSb2prbWdvUC9h?=
 =?utf-8?B?MzI5U0VsNU9nQVFKYmpEbHFOTmgrQm10aUM3dTNiWjg2c21nK0RBVVovNTNn?=
 =?utf-8?B?MVRtR2RLdVZYSVg5Rnc5ZGFTQ1k2S0plY1Z5UFhvank0eXEwSWdET2UzNVlQ?=
 =?utf-8?B?MHRtNm5uZnUwQnFNWTdBVUVRTzM2T1lWZlk1d1NWUVo5d2xqK1U5S285Wllz?=
 =?utf-8?B?U296c2JQYlZmNVA5U0lmcWxveXR6dTR0VGFZbVU5Q3Q3WlZnaEJhRURuVkRV?=
 =?utf-8?B?UExaWk9xN1BUUThTSnBpN2VsRk9CSDY1Z2RMQkRsMTFrT1FoYk1OeXV0cnpq?=
 =?utf-8?B?OVZHU3ZRM1dPNnZaaDlRKzBKZHRnZTZVR1BRNzNEcG51TGFPQ2VsRzBxcXVC?=
 =?utf-8?B?TDVDTThHRTQ2eWNKSnhEb1NzNWRkUy9tTUFNOGcwaEhVVC9PWUpKRXZETWR3?=
 =?utf-8?B?dnpWcmgrZVNCdGNrbWJZV3gxU2V4NkNyRkM3QzVsbmVZYUZXd29VOW82dWdl?=
 =?utf-8?B?NnpHdThjaTJ2WFl6WEIzRnl5TDV4YTJ5dThxb3dPbzIrdm82K1ppZXNWY2NZ?=
 =?utf-8?B?VTFpM3BPL0pMVFYzSUNUQjRwYzRBNERyRFJpSUhEa1BKdllIc2Qra2xjT0w4?=
 =?utf-8?B?eEFMdUtwUld5aWJvNWRHU3FNRGMrTjJKZGIrbGUrYUtEbWpRRmRJYXFKOXI4?=
 =?utf-8?B?Mm5HUWFsVmZrTTJsYzZ2NE85aW5ZZmtoajQ0T3U1S091clMvSFJMRHF4SWJB?=
 =?utf-8?B?a25zbndkdCtGUVkwZ3ZicjBldE1nRjlnU1hIMXZUc2taaStDN2k3YkdjYVcx?=
 =?utf-8?B?cmZRS016MG5KbmY0NXJXRXlkR2M4Sjlxc0ZBSXJhVXBTUW1OUVk2RFo1V0Rh?=
 =?utf-8?B?TFNjZ3piNE1EZE5saU90K2FlZnF3Ri9mbDFoOERCdmViYmttZTBYbjJGQ0dM?=
 =?utf-8?B?Nk94ak5zQ3VqSnNpSFdOZEtOWnJMc1lVV2ovWXd6WU5Rcmlhaldhb1JYT2R4?=
 =?utf-8?B?SHNaWmQ3c1JqencrWWtjblFnMHV2cjBTSTJTazZPTEcxVGlFV1lIMkFRTmNs?=
 =?utf-8?B?Y0t1aG1VZlAxNTJaT3E0SEFZY0hBdS9lNkpMZWRrcTNCRFZzcGxyZmVORkZu?=
 =?utf-8?Q?Iq2lDlzfBtjls/RqgWBNxcC8qOWZY+Buaqi/y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45DFED98C1016741B63A5942D48D9A33@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ouzQV/duSnqj9eQ8t9/zqEveiX83JCuGT5oHXc1tPllABUbVA5x6zkyZdg67BB55FOpVvz5i3+CwYQ9Ebh13EnF3em44ULlGNrGgITl6vBQOny/5npv9YH2OsQRKhWEnVcNgN93pQHv12ucKaLAteirhdT9x4VgmdKw9IN5Izq/U8xCJ68D8ILetsGDfa0T7UBSTXUN2AHJLLXf15FNB4sS9QxlcwS9ZU7BYNPuMaoBps+zejTjTOzLUGOHsyQ2PeGqJmC03mdcPwTlaShQGo2ltTfNjWLi72t049HZt4+KPyP9fFzhNH6IoO2YcN8A22RkmujZYJ3xNX0GUPwFKtA==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18033782-9746-4e44-9816-08de7ed0abf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 18:13:03.6174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l62UL/PqUVKAxWU1cokGv8IIbsrOCF/oF6OU1tLlpUznQ0knaQHxMGuUlis1RXGK2tklHd+kItvBK3L+kVosiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR15MB6945
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b05f35 cx=c_pps
 a=BNrqkoHBqsJX0pt4tOnUqg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=wCmvBT1CAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QMvxmR5twCbtgRVzoWMA:9 a=QEXdDO2ut3YA:10
 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE1NyBTYWx0ZWRfX6gCHa0lwW10o
 lFCMC9kMC4V1/cnjVaPGFjIfGWXKsdgZnbCGIXo54/dpAg7JWd7mfhSnASQrXDTUTtwcKE+KBgi
 ytL71pon3keiWzVbwwYnn9OY+kWcYSSo+GwSIjjjyZbFoNqUgYc3zdF2t7Z0/a44ki+chQhhzEq
 FoPITlX1NgiOfTG1Tj8HMmDqyMEcINWLsIKuJHAszSN+cQdWzaATv028d7PD+ruIUFIgNVIo9JE
 OV6xrRDqYzXJ2+CDYXkhbIl43+KXaWK53hcduLUnuLOMwaWi1K0EuzsTNT6iYzjwF9QeBc+rDZA
 M/VoPBAltcjoFV88J+OQ4rnKEKIaAouRy7fDUJVSU2P978SRDZ588nWomMnMzcpXMsEGQczaEwB
 sh00qtt5B7Ead2PTPCrPKIBigUOv5dYN20g1tjrxMT5SDiF9H3lmVDRqIJNnZY6m1Z8pBjuzwfa
 aeBZIo7XCSVABS5JxWQ==
X-Proofpoint-GUID: ZYPILX7CsvqbmrLJ4cR2j1nTd6r7lS0r
X-Proofpoint-ORIG-GUID: p_Hc_VTpUe9-fUIfURJdp6NY95u6oY9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100157
X-Validation-by: victor.gambier@inria.fr
Subject: Re:  [cocci] [PATCH 03/61] ceph: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
X-Loop: cocci@inria.fr
X-Sequence: 3387
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/1isiVGPejzW5nd4EHKTJHw>

T24gVHVlLCAyMDI2LTAzLTEwIGF0IDEyOjQ4ICswMTAwLCBQaGlsaXBwIEhhaG4gd3JvdGU6DQo+
IFByZWZlciB1c2luZyBJU19FUlJfT1JfTlVMTCgpIG92ZXIgdXNpbmcgSVNfRVJSKCkgYW5kIGEg
bWFudWFsIE5VTEwNCj4gY2hlY2suDQo+IA0KPiBDaGFuZ2UgZ2VuZXJhdGVkIHdpdGggY29jY2lu
ZWxsZS4NCj4gDQo+IFRvOiBJbHlhIERyeW9tb3YgPGlkcnlvbW92QGdtYWlsLmNvbT4NCj4gVG86
IEFsZXggTWFya3V6ZSA8YW1hcmt1emVAcmVkaGF0LmNvbT4NCj4gVG86IFZpYWNoZXNsYXYgRHVi
ZXlrbyA8c2xhdmFAZHViZXlrby5jb20+DQo+IENjOiBjZXBoLWRldmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXBwIEhhaG4gPHBoYWhuLW9zc0Bhdm0uZGU+DQo+IC0tLQ0KPiAgZnMvY2VwaC9kaXIuYyAg
fCAyICstDQo+ICBmcy9jZXBoL3NuYXAuYyB8IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgv
ZGlyLmMgYi9mcy9jZXBoL2Rpci5jDQo+IGluZGV4IDg2ZDdhYTU5NGVhOTkzMzVhZjNlOTFhOTVj
MGE0MThmZGMxYjhhOGEuLjkzNDI1MDc0OGFlNGZkNGMxNDhmZDI3YmRmOTExNzUwNDdjMjg3N2Qg
MTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZGlyLmMNCj4gKysrIGIvZnMvY2VwaC9kaXIuYw0KPiBA
QCAtODg5LDcgKzg4OSw3IEBAIGludCBjZXBoX2hhbmRsZV9ub3RyYWNlX2NyZWF0ZShzdHJ1Y3Qg
aW5vZGUgKmRpciwgc3RydWN0IGRlbnRyeSAqZGVudHJ5KQ0KPiAgew0KPiAgCXN0cnVjdCBkZW50
cnkgKnJlc3VsdCA9IGNlcGhfbG9va3VwKGRpciwgZGVudHJ5LCAwKTsNCj4gIA0KPiAtCWlmIChy
ZXN1bHQgJiYgIUlTX0VSUihyZXN1bHQpKSB7DQo+ICsJaWYgKCFJU19FUlJfT1JfTlVMTChyZXN1
bHQpKSB7DQo+ICAJCS8qDQo+ICAJCSAqIFdlIGNyZWF0ZWQgdGhlIGl0ZW0sIHRoZW4gZGlkIGEg
bG9va3VwLCBhbmQgZm91bmQNCj4gIAkJICogaXQgd2FzIGFscmVhZHkgbGlua2VkIHRvIGFub3Ro
ZXIgaW5vZGUgd2UgYWxyZWFkeQ0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9zbmFwLmMgYi9mcy9j
ZXBoL3NuYXAuYw0KPiBpbmRleCA1MmI0YzI2ODRmOTIyYmZlZDM5NTUwMzExZTc5M2JmZTM2MjJj
ZDI2Li41MjhhZDU4MWJlMTYwNzEzZjkxNDE2MTE1NjU5ZTJkYzZmMjU5NTc2IDEwMDY0NA0KPiAt
LS0gYS9mcy9jZXBoL3NuYXAuYw0KPiArKysgYi9mcy9jZXBoL3NuYXAuYw0KPiBAQCAtOTAyLDcg
KzkwMiw3IEBAIGludCBjZXBoX3VwZGF0ZV9zbmFwX3RyYWNlKHN0cnVjdCBjZXBoX21kc19jbGll
bnQgKm1kc2MsDQo+ICBiYWQ6DQo+ICAJZXJyID0gLUVJTzsNCj4gIGZhaWw6DQo+IC0JaWYgKHJl
YWxtICYmICFJU19FUlIocmVhbG0pKQ0KPiArCWlmICghSVNfRVJSX09SX05VTEwocmVhbG0pKQ0K
PiAgCQljZXBoX3B1dF9zbmFwX3JlYWxtKG1kc2MsIHJlYWxtKTsNCj4gIAlpZiAoZmlyc3RfcmVh
bG0pDQo+ICAJCWNlcGhfcHV0X3NuYXBfcmVhbG0obWRzYywgZmlyc3RfcmVhbG0pOw0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtv
QGlibS5jb20+DQoNClRoYW5rcywNClNsYXZhLg0K
