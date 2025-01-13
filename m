Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7D1C02180
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2025 12:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XqChLg+5aDrTHbbf/SpVbcL6FbQNEvpbGG+zVlzVans=;
  b=bLfCZSps7KZg7CsH+3kC6exujYOjx7iXX//IUn2zcslk4Hrpwy+fDyOX
   77nYmq4v62oCiXY0BZxv9/J6O78rHNk7GDY7p91ijlxJFrU5XgmsS9Asd
   +xvMO1ScbiB/s/EaQ2ZAKYG9wHJqj8Af3zZYsK2MLHV3R1Ovfbb3AFHFe
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="202787959"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jan 2025 13:03:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3C50EE007A; Mon, 13 Jan 2025 13:03:13 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 75ED4E0077
	for <cocci@sympa.inria.fr>; Mon, 13 Jan 2025 12:54:14 +0100 (CET)
IronPort-SDR: 6784fee6_GU3ddn70pspXjEjo7Hn+4evkji2VfD8w9XFv73UY7NYImyE
 tms1iBn5GUW1Z3f273l/TdZeMm9tnEYFhW9mN2A==
X-IPAS-Result: =?us-ascii?q?A0ECBgBZ/YRnjxBBr8ZaHAEBATwBAQQEAQECAQEHAQGBa?=
 =?us-ascii?q?AKCQoFWMQMEC0iNUoZRgiGeG4FAPg8BAwENFBMaAQIEAQEDBIFMjisCHgcBB?=
 =?us-ascii?q?DEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJh?=
 =?us-ascii?q?XsNgluBLF4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAWUBATg7N?=
 =?us-ascii?q?AGDYIJlA7U3gQGCDAEBBoJn2TiBZAmBSAGFaoJjAYsJD4FVRIoNhXeCN4Qng?=
 =?us-ascii?q?QyJdYJchEOBW4MMiF+BTRwDWSwBVRMXCwcFgXMDgRSBTHuCRmlJOgINAjWCH?=
 =?us-ascii?q?nyCK4RchEeEU4VkghSCEYN1HUADC209NxQbBp0ZhCxRAYEmJX9YkkCzHDQHh?=
 =?us-ascii?q?B6BXQYMn3EzqlOIGpBio1+FToFpAjaBXDMaI4M3TwMZD446g2G3HkQyPAIHC?=
 =?us-ascii?q?wEBAwmFRgEBihprYAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 kBtLV15rIqHpYId3Cqul7O52P3Ugd838wgVUA==
IronPort-HdrOrdr: A9a23:a8AprqoUssqQ4FomxsuFx+UaV5o0eYIsimQD101hICG9Ffbo9P
 xG/c566faaslgssR0b9OxoW5PqfZqjz+8W3WB5B97LYOCBggSVxa5Zh7cKqAeAJ8SRzIJg6Z
 s=
X-Talos-CUID: 9a23:3XndDW931w2pWyG6V+OVv0MrBsR5TlaB9lbzA2KHFEtwUYaUWXbFrQ==
X-Talos-MUID: 9a23:UNJH1AvxOuhSWhmci82nvgxYH51K4aqVJGcGzK44pODHMQVfEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="202786381"
X-MGA-submission: =?us-ascii?q?MDFjugnpx7Oc7bFDYqcpmLjrkQ8/GIzELXmK3Y?=
 =?us-ascii?q?nTA5Ho+Fi7ZnNy6y04YWK5yzDzRjlePe2q3Fbu1hpq6AKsaQd+zrgrcc?=
 =?us-ascii?q?5iqzp03m6y+LlltEDVkeqqboBZ2ddQnJCQqMEtgRpLJgTps9x6UlCmnV?=
 =?us-ascii?q?4RHBUhUOwBoRGpNV0UpkeWDw=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 12:54:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736769254; x=1768305254;
  h=from:to:subject:date:message-id:mime-version;
  bh=eRTGdmklt8zhba6hzptVZMni326pwBpRTAVYW57FRSE=;
  b=bdGAeuoLLX6rHsw3pUIit6tDiBYCi0XQ7mag4DCe9eyReWUB1ItxWVfo
   Y9E3CopRMJb+DVFcTfF2Dg1owHH3+nxk8+QZaVWeV0cSVGx4ek/a0yoq6
   O2kfNKzQ2OPcwlxWOkYevrYXOCXke+3yqKd+vpOhRaUMM/KwvCNWo/R+z
   0mW7C588NPX3ccqec04a0YDLraEmfQGdv2JQjjnxsvfRNW+mA4LFHI9eP
   eNMdm89XuD5Pd1IjxOtTtDPEnJojKIXpxQJkyERhEr+wOQDsk038Rhi21
   fKO64euMgAgEb4F/Wm7UghVMaB91ab8DsQ+1BC/hpyJsg9RhaA/s/Qd7D
   Q==;
X-CSE-ConnectionGUID: ymUIf/MrQeKsNYxJB1oZvw==
X-CSE-MsgGUID: uwp+jzBGRjKpLQzWxNYeYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37188259"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37188259"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 03:54:11 -0800
X-CSE-ConnectionGUID: WPpGGrF7QDqbJlADokI0tg==
X-CSE-MsgGUID: xQgS8ubyRT6l2X85h2EJVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104412384"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.145])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 03:54:09 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: cocci@inria.fr
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Date: Mon, 13 Jan 2025 13:54:06 +0200
Message-ID: <87plkrhqu9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] spatch #include statements and include search path
Reply-To: Jani Nikula <jani.nikula@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2198
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/87plkrhqu9.fsf%40intel.com>


I want to use a non-trivial match rule in multiple other rules, in
multiple .cocci files. I'm trying put the match rule in a separate file,
and #include that in the other files, to avoid duplication. (I'm
referring to the "include_cocci ::= #include string" usage of #include,
not transformations.)

It works when the current working directory is the same as the file to
be included, but I seem to be unable to make it work from another
directory.

It doesn't matter if the .cocci files are all in the same directory or
not, it doesn't seem to matter what I pass as -I to spatch on the
command-line. I see #include mentioned in the SmPL Grammar as well as
some tutorials, but I can't find any proper, working examples for it.

How is the #include and the search path supposed to work? There seems to
be some conflation in the documentation about include_cocci in .cocci
and #includes in the .c files.

Specifically, I'm running spatch in my kernel repo, and I keep the
.cocci files in a separate directory outside the kernel repo.

TIA,
Jani.

-- 
Jani Nikula, Intel
