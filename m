Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA6FC28B23
	for <cocci@archiver.kernel.org>; Thu,  6 Mar 2025 09:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CU3smIycQT9MjQ4GLwsssdlVXwc7elZMY/A7sUeeWhU=;
  b=JDvTEqa5lnpXkTmrkNX3AqLz6PoQkRg/d92t/nC2n8nObTthuikUmnkA
   IBDCscFRys2/3Q1C0920Fo8eyyuBirgLvllVOyjLGkrhZpOluq7RoCZX1
   EiGl+3vr6MpcSjbIO3py36VEHZ7YUc9tCdnRHAe5eF+n8BdgMQEYHbZEk
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@suse.cz
X-IronPort-AV: E=Sophos;i="6.14,225,1736809200"; 
   d="scan'208";a="211490448"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Mar 2025 10:08:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 78460E0D3B; Thu,  6 Mar 2025 10:08:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3E5A3E0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 11:51:15 +0100 (CET)
IronPort-SDR: 67c6db22_TFN4dDzrMzOBTWsB9nNmWNxG7tVlECxUe0WxC+oXgJLCmd1
 QkGgEv9OclauiucTxtHYRvFzJQE8ZmFQw13znhQ==
X-IPAS-Result: =?us-ascii?q?A0EDAAD72cZnj4Pfh8NaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFBAwEBAQELAQGBcFKBVzMEC0iNUoZTgiEDi3OFVIEhiyyBf?=
 =?us-ascii?q?g8BAwENRAQBAQMBA4FMgzQCixUCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQA?=
 =?us-ascii?q?QEFAQEBAgEBAgQGAQIQAQEBAQEBOQVJhXsNSQEQAYIHATOCFiwNfQEBAQEDJ?=
 =?us-ascii?q?wsBDQEBNwEPCxUDLisrGQiCeoIxAzEEA64VeIEBM4EBggwBAQbbJw1NH4FlC?=
 =?us-ascii?q?YFIAYhOAYVSGYN9eicbfYEQgRWDKj6CH4F7doV3gjOBaQGDPY5ciCKDB45XU?=
 =?us-ascii?q?nscA1ksAUsKNQw5cEgDgTKBIwU0CnGCC4EyOgINAoJAcB8xhBGCN4Q9XC8DA?=
 =?us-ascii?q?wMDghmBEIFlg2+CEYFdAwMRBQ8Bgx95HIN6f4IwgjwdQAN4PTcUG6I1OoQ6B?=
 =?us-ascii?q?wGBCAUUCBQdLmBlC5MZAbNXhCWETZ0SSQOXLw6TA4gwkE2jegGFNoFuCCuBX?=
 =?us-ascii?q?E04gyJPAxkPjiEZhAnINkI1PAIHAQoBAQMJjWKCBjSBSwEB?=
IronPort-PHdr: A9a23:8+25VhOCE5QGSYmvGpAl6nZsBxdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDvq8r1AeCBN2Cu6gMotGVmp6jcFRD26rJiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhFiiSxbaluI
 Bmqogndq9UajZZhJ6ov1xDEvmZGd+NKyGxnIl6egwzy6sCs8pB97i9eoegh98lOUaX7e6Q3U
 7lVByk4Pm42+cPmqwDNQROA6XUAXGoWlAFIAxXe4xHhQpjxqCr6ufFj1yScIMb7UKo7WTWm7
 6dsVR/olCIKPCM3/W3LlsB9ir9QrQm/rBJj3YHbfICVNOJ/fqzDe9MaWXFBVdtVWyBYH4+wc
 5cDA+8HMO1FrYfyukEOoAOwCwesGu3i1CJGiHz43aI1z+suDA7I0w47EtISs3nat8n5OLsOX
 eyoyqTD0DXNb+lR2Tf48IXGdgouofeRVrx1a8XR01MgHB7Cg1WSs4PqIzCV2/8Ws2iG9OpvS
 /ijhHImqgxopDWk28gjhJXTiI0P1lDE6Tt2wJwzJdCgR0B2Yt6pHYdOuyyYN4Z7Q8MvTmBnt
 is01LALupG2cDYWxZklxhPRZOCLf5aI7xztSeqcIzN1iXN7dLyxmRu+706twfD/WMmsyFtGs
 y5In9nWunwQ2RHe6tKLRuVj8kqvwzqDyg7e5vxcLUwqj6XXN5wsz7stmZUNvknPAir7l17og
 KKVa0kp//Wk5/jmb7jju5OQK4p5hhz+P6gyn8GyAOs1Pw0TU2Wa++mx0qDo8FP9QLVXlf02j
 rfWsIrHK8Qap6+2HRdY3pol5h2iFTmpys4YkmMCLF9deBKIkYzpO1bWLfDjCPe/n0ysnC5sx
 /DbIr3tHI/BLmPekLf6Y7lx8VNTxxQrwdBe4ZJbFK0BLeruVkL1tNHUFAI1PgK0zur9Ftlxy
 I0TVXiSDqKXLa/eqVqI6fguI+mIao8VojH9K/096v7sl3A2hVwdcLKy3ZsKc3C3AO5qLFmYY
 Hb0hNcOCn8FvhAiQ+zylF2CTTlTam6vU64k/DE0FJqmDZvfRoCqmLGOwCC7EYFKaWBHEV2MC
 nfpd4CcW/gWci6SI8lhkiYFVbe7UYMh2wuu50fGzO9sIfjT/CADnZ3k09dx6ujalBV0/jtxX
 OqH1GTYbWhy1kABXTZ+iKJ2qk9V0UqY3O5zkaoLRpRo+/pVX1JiZtbnxOtgBoW3A1qZFj/oY
 FOvQ9H9RCo0Usp02NgWJUB0B9SliBnHmSusGb4c0bKRV9Qv6qyJ+X/3Ko5mzmrekrE7hgwkS
 8BMHXa7naM5/BqAT5XRnRChnr2xPb8ZwDaL8W6CyWSUu0QNUgd7Uo3eQGsSIEDE/pzi/k2Xa
 bioBPw8NxdZj86PLqwfctrykVBPX+vuIvzFZn6p3mCtGUzO3a6XYczmdg3xxQ37D04J20AW9
 HeCbk0lAzu55nnZFHpoHE7uZEXl9a9/rmm6Rwk61VPCaUopzLez9hMP4J7UA/oOwrIJvjsgo
 DRoDR682dzREd+Juwtmeu1Vf9o85F5N0W+RuRZ6O9SsKKVrh1hWdAoS3Qum1Rx8Ca1bjNMn6
 ng4jUJzJa+ezFJdZmaAx5mjcrbTK2T04FWuc/uPiwyYiY3LvP1Vs7Jh8Ayw2WPhXlAv+Hhmz
 dRPhn6V55GRSREXTYq0SUEvsR5zu7DdZCA5oYLSz3xld6eu4Vqgk5okAvUozhG4cpJRKqSBQ
 UXwGsYZL9OzM+FskErjPVoUeftf8qI5JZbsdfKN24awIf1t2jm0xzcigsg1wgeH8CxyTfTN1
 pAOzqSD3weJYDz7iU+orsH9nY0siSg6JmOk0mCkAYdQYvY3ZoMXESK1JNXxwNxihpnrUnoe9
 Vi5BlpA1tX7MRaValX820VX2yF16TSlkCC75ydpiDxvpbjX0CHVwuvkfQYKISYSFTQk1AyxZ
 9Lu1JZDBxHgZhNhjBa/4Efm26VX7L9yKWXeWwYtHWC+Lm1vVLexqqvXZsdO7J0ytiAEGO+4Y
 F2cVvv8u05Dgn6lRjADgmphLHfz4cyq+n4ywHiQJ3tysnfDLMR5xBOEocfZWeYUxT0eAi9xl
 TjQAFG4ediv59Sd0ZnZ4YXcHyqsUINedS7zwMaOriy+sCdoCBa8t+uugdChGhpwgmfrksJnU
 ynFtkO2YIDg1IyhLPlqOEJ6TgyZiYIyCsR1lY0+g4sV0H4Ri8CO/HYJpmz0NM1SxaP0aHdeD
 S5O2dPe5xLpnVFyNn/cjZysTW2Tm4EyArvyKnNTwC826NpGTbuZ/KAR1zUguUK29ErQeaQvx
 2ZAj6J1tThA2bpP4VF1iX7HZ9JaVUhAYX61xknOtovj6v8NPyD2KuH3jxA2nMj/XuuL+l4OV
 HulIsUoR3IpvJwnaQCViC+qt9m2JoWCNJVK7E3x8V+IjvALesg4zqVYiSc7YTD35yB8mbdj1
 E43hcPj4dDVdTk/puXgWE4QNzv+Y94f92P2kL1T2MqbuuLnVpRnETEWUJa6SPupFDkVs+j9M
 ALIGzo54mGSHb6VdeOGwGFhqX+HU5WiNnXMYWIc0c0nXx6FYkpWnAETWjw+2J8/DAGjgsL7I
 g9/4XgK61j0pwEpqKogPgTjUmrZuAajayslAJmZIh1M6whe5kDTecWA5+N3Fitc89WvtguIY
 mCcYg1JCykOVCnmTxj7OaKy4NDb7+WCLvG7M+OLZqiS86pFSuyFg56ik8Nn8zuKKsSTLyxiA
 vk8iS8hFThyH8XUnSlKSjRCznOQKZfA+VHmoHYx95vmo5GJEEr16ICCCqVfK4Bq8hGy2uKYM
 vKIwT1+MXBe348NwnnBzP4e2kQTgmdgbWrIc/xIuCjTQabXgqISAQQcbnY5NsJD7IonwxJAf
 8XJwICQtPYwnrsuBlFJWEa00NmuftAPKnqhOUnvH0OXLPGBOCGRhdrqeq76RbAa34A2/1Wg/
 D2cFUHkJDGKkTLkAguuPe97hyaeJBVCuYu5f36F7ED4UcnrLBapYocfZdIe2qAvizXBJzxFW
 dCdW1hIsqXV6j5E2LNkBndMqHZof7Hspg==
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:/C5ut6+TwuLBKdjEFXpuk+AfI+orL9Y04lQ7vn2ZKSY4TiVXrb
 HIoB0+726ItN93YgBdpTngAtj7fZq4z/QZjucs1NiZLWvbUQeTXeRfBM7ZskLd8k7Fh5VgPM
 VbAtFD4bTLZDAQ7KaKgzVQUexQuOVvm5rY49s2oU0dKT2ChpsQnDuREDzrbHFedU19HJI8UK
 CX4NFKzgDQCUg/X4CAH3EAUqz5q8fWkY+OW292OyIa
X-Talos-CUID: 9a23:a4pzN2PlgTX+re5DBQZazXw2Fe4ZfXDe0kfxDVOZI2pgV+jA
X-Talos-MUID: 9a23:tcaDbAaSPHkfpOBTnTzW2h9QJphSwPq+BHsUsIwCpNmkKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="110601624"
X-MGA-submission: =?us-ascii?q?MDHoFGY9dTHLVa/XbXlLf5BE/o7hgOcXAm1j2b?=
 =?us-ascii?q?HZ/CyOiPzWW9pYso6+THqQLaoQtrx/ddIkhAa+NQBCoi+ofphVNhPRvn?=
 =?us-ascii?q?6ggJm6AIPP9MvNKoBRYWrV6EnZ5TCqFK+DHM+d0Mve1SQZxUz3jhLkau?=
 =?us-ascii?q?Q+wzwaG3wXjRyAgr7Wd0B/QQ=3D=3D?=
Received: from smtp-out2.suse.de ([195.135.223.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 11:51:14 +0100
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C21F1F393;
	Tue,  4 Mar 2025 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741085473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU3smIycQT9MjQ4GLwsssdlVXwc7elZMY/A7sUeeWhU=;
	b=BPLurmrQ3oFJdqSZUBdE7WRt7WOHkabw9pgHLwVgofOT1PPTJs8UwZ4Af/awp4TtVF/YdW
	syCQPA/k4sSmcXSTc+LXGs9qWb4G9l8Z2dxXxWiAV0mNiC5VTttNShqIpdw7wGyNjuYhfp
	JbLSxirAqD4z5uRT7/a6a6iWdTrKALI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741085473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU3smIycQT9MjQ4GLwsssdlVXwc7elZMY/A7sUeeWhU=;
	b=FwaEmFZnTf5xQFACU7tvOF6aocbG1wVm6tn4dQuSPoY62TRl5ScdMhceoL/onXH7w3SFQy
	PppvLITPLR9XTMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741085473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU3smIycQT9MjQ4GLwsssdlVXwc7elZMY/A7sUeeWhU=;
	b=BPLurmrQ3oFJdqSZUBdE7WRt7WOHkabw9pgHLwVgofOT1PPTJs8UwZ4Af/awp4TtVF/YdW
	syCQPA/k4sSmcXSTc+LXGs9qWb4G9l8Z2dxXxWiAV0mNiC5VTttNShqIpdw7wGyNjuYhfp
	JbLSxirAqD4z5uRT7/a6a6iWdTrKALI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741085473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU3smIycQT9MjQ4GLwsssdlVXwc7elZMY/A7sUeeWhU=;
	b=FwaEmFZnTf5xQFACU7tvOF6aocbG1wVm6tn4dQuSPoY62TRl5ScdMhceoL/onXH7w3SFQy
	PppvLITPLR9XTMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00A5A1393C;
	Tue,  4 Mar 2025 10:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2WIdACHbxmfsaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Mar 2025 10:51:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BCA57A0912; Tue,  4 Mar 2025 11:51:08 +0100 (CET)
Date: Tue, 4 Mar 2025 11:51:08 +0100
From: Jan Kara <jack@suse.cz>
To: cgzones@googlemail.com
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, cocci@inria.fr, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	linux-ext4@vger.kernel.org
Message-ID: <kmfmwblxeav63y3noxb65pkrzw5nggbrwxblgtzt3ntag4gwrz@bz3r2vpnkozb>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-2-cgoettsche@seltendoof.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302160657.127253-2-cgoettsche@seltendoof.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[googlemail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 03/11] ext4: reorder capability check last
Reply-To: Jan Kara <jack@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 2544
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/kmfmwblxeav63y3noxb65pkrzw5nggbrwxblgtzt3ntag4gwrz%40bz3r2vpnkozb>

On Sun 02-03-25 17:06:39, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/balloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 8042ad873808..c48fd36b2d74 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -649,8 +649,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
>  	/* Hm, nope.  Are (enough) root reserved clusters available? */
>  	if (uid_eq(sbi->s_resuid, current_fsuid()) ||
>  	    (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) && in_group_p(sbi->s_resgid)) ||
> -	    capable(CAP_SYS_RESOURCE) ||
> -	    (flags & EXT4_MB_USE_ROOT_BLOCKS)) {
> +	    (flags & EXT4_MB_USE_ROOT_BLOCKS) ||
> +	    capable(CAP_SYS_RESOURCE)) {
>  
>  		if (free_clusters >= (nclusters + dirty_clusters +
>  				      resv_clusters))
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
