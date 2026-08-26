Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D676C61DBE
	for <cocci@archiver.kernel.org>; Wed, 26 Aug 2026 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z0QoZ1hkGgLO/uxxO2HH8CGD2f3tM4N6MTGCRVY3c/M=;
  b=P1orsOYlrzzN44Yp8U9khbq4HiGA9skcsxJ9Cx0+kfXGiccR8C7VbQWl
   RepHM3KbBnVpbGZ7WBkJkNkSw0b4BDjhPTAbN5jzCkwPeP1Qu8CsijV/g
   p0rL0a0W5BvhbPafKmeUIAEqNAQ+5DmcMthym2WcpdSbeB1ovQqn627K0
   8=;
X-CSE-ConnectionGUID: fI1y74mSRA+H/1Q5oYUIBg==
X-CSE-MsgGUID: CynLgw/fRrOP/tDZ8XsFlw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,244,1779141600"; 
   d="scan'208";a="291620320"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Aug 2026 12:57:28 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id B104180588; Wed, 26 Aug 2026 12:57:27 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4E68C81D4E
	for <cocci@sympa.inria.fr>; Wed, 26 Aug 2026 10:11:46 +0200 (CEST)
X-CSE-ConnectionGUID: nC8PEzM3SfCsZ1l+mfgZhQ==
X-CSE-MsgGUID: 65Pz8TW2T5iVzuMFXUuXjA==
IronPort-SDR: 6a8e9fc1_ewdpotWIi4KmDEArK7dt/7vbWLU/oyweWHC3j+m714nGiAn
 0vJPsKIl2mcKbgUeW8YJOl8mRjtLGcSosxxLehw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0GfAgBEno5qgA4P49RaglmCQYEKXjQEC0mEWI9SgiSEO?=
 =?us-ascii?q?5lggXwCDwEDAQ09EQECBAEBAQIEgguCcwKNbQIeBwEEMQgOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBOwcOO4ZPDYJbgSyBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CDTpEAQEBAgEjBBkBAREnDwsaAhgOAgJWGwEBgn4BgiIBB?=
 =?us-ascii?q?hABAxAnBw2/a38zgQGCDAEBBoJq138fLCJdgWkDBoEfLoVxgm0BinQnD4FVR?=
 =?us-ascii?q?IEVJwuCeT6EQ4NbgmqCJoEMhESPHlJ4HANZLAFVExcLBwWBI0MDgQYjDzwFL?=
 =?us-ascii?q?R2BIyEdFxceWBsGBRIgKkFEIwM+gRlBAoF1PyMZNnyBCV6BKylhAhAXRi4Vg?=
 =?us-ascii?q?gcCglqBJwJcAgFJQw4HRz4LbT03CQsZBD2PYR+BV4IsgkjGNTQHgjmBaIFmD?=
 =?us-ascii?q?IowlT8GEy+XUw6TCyyYXI4KmzmBagE3gVwzGiSDNlADGQ+OLRaDYDPLaEUyA?=
 =?us-ascii?q?j0HAgcPAoVPAQGMVoFMAQE?=
IronPort-PHdr: A9a23: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
 jfni6/5bjtPoYu8wA==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:y6CcB6BSefRJBAjlHely55DYdb4zR+YMi2TDpHoBLSC9Ffbo7v
 xG/c5rsyMc7Qx7ZJhOo7+90cW7MBDhHNtOkO4s1NSZMjUO2lHFEGgK1+KLrgEIWReOk9K1vp
 0BT0ERMqyTMXFHrYLd/BSyFcomzeKK6aaymI7lvg1QpE1RCp2J9G1Ce36m+6BNNXJ77RFVLv
 Ch2vY=
X-Talos-CUID: 9a23:uBLgUGBJQvaS/ID6Ey9MpHY5COV+SXP210WJJwy9B2lbSITAHA==
X-Talos-MUID: 9a23:54SdXwl6C6NJxk9L85gbdno8af96s5iRUnxQkKsUpuyqBRFtCzW02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,244,1779141600"; 
   d="scan'208";a="155059982"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDH84G1MAdLh/ypFjUGmQdHRKARRO/u83+F5lq?=
 =?us-ascii?q?DKXSMLvqzRFphfzY5qLAQKxBjhzL0NLlqoNM3x6hgbOm4ItgRRnBii87?=
 =?us-ascii?q?F1g+UIyrBz9n9VzNYdUx4wM8RHhDtXuCWkd0r9JLspj+YLSpPl0n5gll?=
 =?us-ascii?q?cSHGO8r/bgEFv+HRg5JcCaCg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 10:11:45 +0200
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrfou-1wbuse1Rga-00lpqq for
 <cocci@inria.fr>; Wed, 26 Aug 2026 10:11:44 +0200
Message-ID: <251ea667-c8b8-4d71-9397-86835c1dcf88@web.de>
Date: Wed, 26 Aug 2026 10:11:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <95c4aa23-d13d-4ec3-89a8-5df56844addf@web.de>
 <acc76ef2-2a0-f716-ff28-f8be945db26d@inria.fr>
 <0fbe54d4-d595-4fcc-bba7-14da44ca3f0d@web.de>
 <3f2a4432-375d-4a93-ba53-11006d0c2fd6@web.de>
 <b7cba424-69d9-5534-85dd-e3cf5098e4af@inria.fr>
 <a6f6fee5-d935-48eb-82b0-63e202f25529@web.de>
 <eac84dab-f980-a9fd-e37c-b8259140b4ed@inria.fr>
 <5b9536bb-5a8f-436f-9dd4-9d0ffe34c4a3@web.de>
 <5acea20e-16ce-4d49-98ce-79a3f7beae4c@web.de>
Content-Language: en-GB, de-DE
In-Reply-To: <5acea20e-16ce-4d49-98ce-79a3f7beae4c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:su7sTz4BeAfxpFDlHhb4Q5fHGTHq0JevP0NPo8IgpgekHSPTwbl
 jg1v93QbS7xFl+SK7ZVANZVtWSEPJZS20FFRySYidM53EySgnq3pvqxesFttObCqMqeiDYz
 vhzf4CPgSC9SxvTAv6mZX9mWRxleTnHnnLvNucrnQSPK7nM06Ib7r3cri9KrpQv+QazlUwi
 pv/GV5TnDsaQGLAjckiNQ==
UI-OutboundReport: notjunk:1;M01:P0:6Go311wI7YY=;0jqpePq3pLg0ECAkIww19kdeAhY
 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
 umfRLqbSBAS8WAeK7G+E=
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Checking run time characteristics for longer SmPL
 disjunctions?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3711
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/sGByY7tAqI-ldGurgdbmcQ>

>> Do they trigger desirable grep queries?
>=20
> I would like to share some data from another test run.
> https://elixir.bootlin.com/linux/v6.18-rc5/source/include/rdma
>=20
> Generated SmPL script (with some tweaks):
> @replacements@
> expression a, access_flags, ateth, attr_bkey, attr_key, attrs_bundle, b,=
 biter, bundle, client, comp_vector, cpi, cq, def_val, dest, dev_addr, dir=
ection, dma_addr, entry, filp, flags, gid, hdr, ibah, ibcq, ibpd, ibqp, ib=
srq, idx, init_attr, ioctl_method_key, key, lower_bound, mr, n, nents, net=
_dev, nr_cqe, nr_top_bits, num_entries, offset, ohdr, p, pd, pgoff, pgoff_=
bitmask, pgsz, pgsz_bitmap, poll_ctx, port, private, ptr, qp, rdi, rec, re=
s, reth, rmpp_hdr, rq, sg, size, smp, src, srq_type, swqe, to, ucontext, u=
data, umem, umem_odp, uobj, upper_bound, wc, x_attr, x_attrs, x_dev, x_dev=
ice, x_ibdev, x_len, x_length, x_port_num, x_wr;
> typedef u8, u16, u32, u64, uintptr_t;
> @@
> (
> -! ! ( x_device -> attrs . kernel_cap_flags & IBK_RDMA_NETDEV_OPA )
> +rdma_cap_opa_vnic(x_device)
> |
> -uobj -> uapi_object -> id
> +uobj_get_object_id(uobj)
> |
> -! res -> user
> +rdma_is_kernel_res(res)
> |
> -! res -> no_track
> +rdma_restrack_is_tracked(res)
> |
> -( u8 ) ( be32_to_cpu ( cpi -> cap_mask2_resp_time ) & IB_CLASS_PORT_INF=
O_RESP_TIME_MASK )
> +ib_get_cpi_resp_time(cpi)
> |
> -rmpp_hdr -> rmpp_rtime_flags & 0x7
> +ib_get_rmpp_flags(rmpp_hdr)
> |
> -rmpp_hdr -> rmpp_rtime_flags >> 3
> +ib_get_rmpp_resptime(rmpp_hdr)
> |
> -( ( smp -> status & IB_SMP_DIRECTION ) =3D=3D IB_SMP_DIRECTION )
> +ib_get_smp_direction(smp)
> |
> -be16_to_cpu ( * ptr )
> +_iba_get16(ptr)
> |
> -be32_to_cpu ( * ptr )
> +_iba_get32(ptr)
> |
> -be64_to_cpu ( get_unaligned ( ptr ) )
> +_iba_get64(ptr)
> |
> - * ptr
> +_iba_get8(ptr)
> |
> -ib_get_smp_direction ( ( struct ib_smp * ) smp )
> +opa_get_smp_direction(smp)
> |
> -container_of ( ibqp , struct rvt_qp , ibqp )
> +ibqp_to_rvtqp(ibqp)
> |
> -container_of ( ibsrq , struct rvt_srq , ibsrq )
> +ibsrq_to_rvtsrq(ibsrq)
> |
> -( ( ( int ) a ) - ( ( int ) b ) ) << 8
> +rvt_cmp_msn(a, b)
> |
> -x_len >> qp -> log_pmtu
> +rvt_div_mtu(qp, x_len)
> |
> -( x_len + qp -> pmtu - 1 ) >> qp -> log_pmtu
> +rvt_div_round_up_mtu(qp, x_len)
> |
> -( struct rvt_rwqe * ) ( ( char * ) rq -> kwq -> curr_wq + ( sizeof ( st=
ruct rvt_rwqe ) + rq -> max_sge * sizeof ( struct ib_sge ) ) * n )
> +rvt_get_rwqe_ptr(rq, n)
> |
> -ibah_to_rvtah ( swqe -> ud_wr . wr . ah )
> +rvt_get_swqe_ah(swqe)
> |
> -swqe -> ud_wr . attr
> +rvt_get_swqe_ah_attr(swqe)
> |
> -swqe -> ud_wr . wr . pkey_index
> +rvt_get_swqe_pkey_index(swqe)
> |
> -( struct rvt_swqe * ) ( ( char * ) qp -> s_wq + ( sizeof ( struct rvt_s=
wqe ) + qp -> s_max_sge * sizeof ( struct rvt_sge ) ) * n )
> +rvt_get_swqe_ptr(qp, n)
> |
> -swqe -> ud_wr . wr . remote_qkey
> +rvt_get_swqe_remote_qkey(swqe)
> |
> -swqe -> ud_wr . wr . remote_qpn
> +rvt_get_swqe_remote_qpn(swqe)
> |
> -! ! qp -> pid
> +rvt_is_user_qp(qp)
> |
> -( ( u16 ) dev_addr -> broadcast [ 8 ] << 8 ) | ( u16 ) dev_addr -> broa=
dcast [ 9 ]
> +ib_addr_get_pkey(dev_addr)
> |
> -dev_addr -> dev_type =3D=3D ARPHRD_INFINIBAND ? 4 : 0
> +rdma_addr_gid_offset(dev_addr)
> |
> -is_vlan_dev ( x_dev ) ? vlan_dev_real_dev ( x_dev ) : NULL
> +rdma_vlan_dev_real_dev(x_dev)
> |
> -is_vlan_dev ( x_dev ) ? vlan_dev_vlan_id ( x_dev ) : 0xffff
> +rdma_vlan_dev_vlan_id(x_dev)
> |
> -container_of ( x_wr , struct ib_atomic_wr , x_wr )
> +atomic_wr(x_wr)
> |
> -access_flags & ( IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_AC=
CESS_REMOTE_ATOMIC | IB_ACCESS_MW_BIND )
> +ib_access_writable(access_flags)
> |
> -__ib_alloc_cq ( x_dev , private , nr_cqe , comp_vector , poll_ctx , KBU=
ILD_MODNAME )
> +ib_alloc_cq(x_dev, private, nr_cqe, comp_vector, poll_ctx)
> |
> -__ib_alloc_cq_any ( x_dev , private , nr_cqe , poll_ctx , KBUILD_MODNAM=
E )
> +ib_alloc_cq_any(x_dev, private, nr_cqe, poll_ctx)
> |
> -copy_from_user ( dest , udata -> inbuf , x_len ) ? - EFAULT : 0
> +ib_copy_from_udata(dest, udata, x_len)
> |
> -copy_to_user ( udata -> outbuf , src , x_len ) ? - EFAULT : 0
> +ib_copy_to_udata(udata, src, x_len)
> |
> -ib_create_qp_kernel ( pd , init_attr , KBUILD_MODNAME )
> +ib_create_qp(pd, init_attr)
> |
> -ib_dereg_mr_user ( mr , NULL )
> +ib_dereg_mr(mr)
> |
> -ib_destroy_qp_user ( qp , NULL )
> +ib_destroy_qp(qp)
> |
> -refcount_inc_not_zero ( & x_dev -> refcount )
> +ib_device_try_get(x_dev)
> |
> -ib_dma_map_sg_attrs ( x_dev , sg , nents , direction , 0 )
> +ib_dma_map_sg(x_dev, sg, nents, direction)
> |
> -xa_load ( & x_device -> client_data , client -> client_id )
> +ib_get_client_data(x_device, client)
> |
> -( netif_running ( net_dev ) && netif_carrier_ok ( net_dev ) ) ? IB_PORT=
_ACTIVE : IB_PORT_DOWN
> +ib_get_curr_port_state(net_dev)
> |
> -ib_is_buffer_cleared ( udata -> inbuf + offset , x_len )
> +ib_is_udata_cleared(udata, offset, x_len)
> |
> -cq -> device -> ops . poll_cq ( cq , num_entries , wc )
> +ib_poll_cq(cq, num_entries, wc)
> |
> -cq -> device -> ops . req_notify_cq ( cq , flags )
> +ib_req_notify_cq(cq, flags)
> |
> -srq_type =3D=3D IB_SRQT_XRC || srq_type =3D=3D IB_SRQT_TM
> +ib_srq_has_cq(srq_type)
> |
> -IS_ENABLED ( CONFIG_INFINIBAND_VIRT_DMA ) && ! x_dev -> dma_device
> +ib_uses_virt_dma(x_dev)
> |
> -virt_to_page ( ib_virt_dma_to_ptr ( dma_addr ) )
> +ib_virt_dma_to_page(dma_addr)
> |
> -( void * ) ( uintptr_t ) dma_addr
> +ib_virt_dma_to_ptr(dma_addr)
> |
> -x_attr -> ah_flags
> +rdma_ah_get_ah_flags(x_attr)
> |
> -x_attr -> port_num
> +rdma_ah_get_port_num(x_attr)
> |
> -x_attr -> sl
> +rdma_ah_get_sl(x_attr)
> |
> -x_attr -> static_rate
> +rdma_ah_get_static_rate(x_attr)
> |
> -biter -> __dma_addr & ~ ( BIT_ULL ( biter -> __pg_bit ) - 1 )
> +rdma_block_iter_dma_address(biter)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_AF_IB
> +rdma_cap_af_ib(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_ETH_AH
> +rdma_cap_eth_ah(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_IB_CM
> +rdma_cap_ib_cm(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_IB_MAD
> +rdma_cap_ib_mad(x_device, x_port_num)
> |
> -rdma_cap_ib_sa ( x_device , x_port_num )
> +rdma_cap_ib_mcast(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_IB_SA
> +rdma_cap_ib_sa(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_IB_SMI
> +rdma_cap_ib_smi(x_device, x_port_num)
> |
> -x_device -> is_switch
> +rdma_cap_ib_switch(x_device)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_IW_CM
> +rdma_cap_iw_cm(x_device, x_port_num)
> |
> -( x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & R=
DMA_CORE_CAP_OPA_AH ) =3D=3D RDMA_CORE_CAP_OPA_AH
> +rdma_cap_opa_ah(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_OPA_MAD
> +rdma_cap_opa_mad(x_device, x_port_num)
> |
> -rdma_protocol_iwarp ( x_dev , x_port_num )
> +rdma_cap_read_inv(x_dev, x_port_num)
> |
> -rdma_protocol_roce ( x_device , x_port_num ) && x_device -> ops . add_g=
id && x_device -> ops . del_gid
> +rdma_cap_roce_gid_table(x_device, x_port_num)
> |
> -( x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & R=
DMA_CORE_PORT_INTEL_OPA ) =3D=3D RDMA_CORE_PORT_INTEL_OPA
> +rdma_core_cap_opa_port(x_device, x_port_num)
> |
> -read_pnet ( & x_device -> coredev . rdma_net )
> +rdma_dev_net(x_device)
> |
> -rdma_cap_ib_switch ( x_device ) ? 0 : x_device -> phys_port_cnt
> +rdma_end_port(x_device)
> |
> -rdma_protocol_ib ( x_device , x_port_num ) || rdma_protocol_roce ( x_de=
vice , x_port_num )
> +rdma_ib_or_roce(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_PORT_IB_GRH_REQUIRED
> +rdma_is_grh_required(x_device, x_port_num)
> |
> -( port >=3D rdma_start_port ( x_device ) && port <=3D rdma_end_port ( x=
_device ) )
> +rdma_is_port_valid(x_device, port)
> |
> -x_device -> port_data [ x_port_num ] . immutable . max_mad_size
> +rdma_max_mad_size(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_PROT_IB
> +rdma_protocol_ib(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_PROT_IWARP
> +rdma_protocol_iwarp(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_PROT_RAW_PACKET
> +rdma_protocol_raw_packet(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & ( R=
DMA_CORE_CAP_PROT_ROCE | RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP )
> +rdma_protocol_roce(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_PROT_ROCE
> +rdma_protocol_roce_eth_encap(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_PROT_ROCE_UDP_ENCAP
> +rdma_protocol_roce_udp_encap(x_device, x_port_num)
> |
> -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDM=
A_CORE_CAP_PROT_USNIC
> +rdma_protocol_usnic(x_device, x_port_num)
> |
> -rdma_cap_ib_switch ( x_device ) ? 0 : 1
> +rdma_start_port(x_device)
> |
> -rdma_user_mmap_entry_insert_range ( ucontext , entry , x_length , pgoff=
 , pgoff )
> +rdma_user_mmap_entry_insert_exact(ucontext, entry, x_length, pgoff)
> |
> -( u64 ) entry -> start_pgoff << PAGE_SHIFT
> +rdma_user_mmap_get_offset(entry)
> |
> -container_of ( x_wr , struct ib_rdma_wr , x_wr )
> +rdma_wr(x_wr)
> |
> -container_of ( x_wr , struct ib_reg_wr , x_wr )
> +reg_wr(wr)
> |
> -container_of ( x_wr , struct ib_ud_wr , x_wr )
> +ud_wr(x_wr)
> |
> -__rdma_block_iter_next ( biter ) && biter -> __sg_numblocks --
> +__rdma_umem_block_iter_next(biter)
> |
> -ib_umem_start_dma_addr ( umem ) & ( pgsz - 1 )
> +ib_umem_dma_offset(umem, pgsz)
> // |
> // -0
> // +ib_umem_find_best_pgoff(umem, pgsz_bitmap, pgoff_bitmask)
> |
> -( size_t ) ( ( ALIGN ( umem -> iova + umem -> length , pgsz ) - ALIGN_D=
OWN ( umem -> iova , pgsz ) ) ) / pgsz
> +ib_umem_num_dma_blocks(umem, pgsz)
> |
> -ib_umem_num_dma_blocks ( umem , PAGE_SIZE )
> +ib_umem_num_pages(umem)
> |
> -umem -> address & ~ PAGE_MASK
> +ib_umem_offset(umem)
> |
> -sg_dma_address ( umem -> sgt_append . sgt . sgl ) + ib_umem_offset ( um=
em )
> +ib_umem_start_dma_addr(umem)
> |
> -container_of ( umem , struct ib_umem_dmabuf , umem )
> +to_ib_umem_dmabuf(umem)
> |
> -( rec -> rec_type =3D=3D SA_PATH_REC_TYPE_OPA )
> +sa_path_is_opa(rec)
> |
> -( ( rec -> rec_type =3D=3D SA_PATH_REC_TYPE_ROCE_V1 ) || ( rec -> rec_t=
ype =3D=3D SA_PATH_REC_TYPE_ROCE_V2 ) )
> +sa_path_is_roce(rec)
> |
> -container_of ( ibcq , struct rvt_cq , ibcq )
> +ibcq_to_rvtcq(ibcq)
> |
> -ib_u64_get ( & ateth -> compare_data )
> +get_ib_ateth_compare(ateth)
> |
> -ib_u64_get ( & ateth -> swap_data )
> +get_ib_ateth_swap(ateth)
> |
> -ib_u64_get ( & ateth -> vaddr )
> +get_ib_ateth_vaddr(ateth)
> |
> -ib_u64_get ( & reth -> vaddr )
> +get_ib_reth_vaddr(reth)
> |
> -( u8 ) ( ( be32_to_cpu ( ohdr -> bth [ 2 ] ) >> IB_BTH_A_SHIFT ) & IB_B=
TH_A_MASK )
> +ib_bth_get_ackreq(ohdr)
> |
> -( ohdr -> bth [ 1 ] ) & cpu_to_be32 ( IB_BECN_SMASK )
> +ib_bth_get_becn(ohdr)
> |
> -( ohdr -> bth [ 1 ] ) & cpu_to_be32 ( IB_FECN_SMASK )
> +ib_bth_get_fecn(ohdr)
> |
> -( u8 ) ( ( be32_to_cpu ( ohdr -> bth [ 0 ] ) >> IB_BTH_M_SHIFT ) & IB_B=
TH_M_MASK )
> +ib_bth_get_migreq(ohdr)
> |
> -( ( be32_to_cpu ( ohdr -> bth [ 0 ] ) >> IB_BTH_OPCODE_SHIFT ) & IB_BTH=
_OPCODE_MASK )
> +ib_bth_get_opcode(ohdr)
> |
> -( ( be32_to_cpu ( ohdr -> bth [ 0 ] ) >> IB_BTH_PAD_SHIFT ) & IB_BTH_PA=
D_MASK )
> +ib_bth_get_pad(ohdr)
> |
> -( be32_to_cpu ( ohdr -> bth [ 0 ] ) & IB_BTH_PKEY_MASK )
> +ib_bth_get_pkey(ohdr)
> |
> -( u32 ) ( be32_to_cpu ( ohdr -> bth [ 2 ] ) )
> +ib_bth_get_psn(ohdr)
> |
> -( u32 ) ( ( be32_to_cpu ( ohdr -> bth [ 1 ] ) ) & IB_QPN_MASK )
> +ib_bth_get_qpn(ohdr)
> |
> -( u8 ) ( ( be32_to_cpu ( ohdr -> bth [ 0 ] ) >> IB_BTH_SE_SHIFT ) & IB_=
BTH_SE_MASK )
> +ib_bth_get_se(ohdr)
> |
> -( u8 ) ( ( be32_to_cpu ( ohdr -> bth [ 0 ] ) >> IB_BTH_TVER_SHIFT ) & I=
B_BTH_TVER_MASK )
> +ib_bth_get_tver(ohdr)
> |
> -ohdr -> bth [ 0 ] & cpu_to_be32 ( IB_BTH_MIG_REQ )
> +ib_bth_is_migration(ohdr)
> |
> -ohdr -> bth [ 0 ] & cpu_to_be32 ( IB_BTH_SOLICITED )
> +ib_bth_is_solicited(ohdr)
> |
> -( be16_to_cpu ( hdr -> lrh [ 1 ] ) )
> +ib_get_dlid(hdr)
> |
> -( be16_to_cpu ( hdr -> lrh [ 0 ] ) & IB_LNH_MASK )
> +ib_get_lnh(hdr)
> |
> -( u8 ) ( ( be16_to_cpu ( hdr -> lrh [ 0 ] ) >> IB_LVER_SHIFT ) & IB_LVE=
R_MASK )
> +ib_get_lver(hdr)
> |
> -be32_to_cpu ( ohdr -> u . ud . deth [ 0 ] )
> +ib_get_qkey(ohdr)
> |
> -( ( be16_to_cpu ( hdr -> lrh [ 0 ] ) >> IB_SC_SHIFT ) & IB_SC_MASK )
> +ib_get_sc(hdr)
> |
> -( ( be16_to_cpu ( hdr -> lrh [ 0 ] ) >> IB_SL_SHIFT ) & IB_SL_MASK )
> +ib_get_sl(hdr)
> |
> -( be16_to_cpu ( hdr -> lrh [ 3 ] ) )
> +ib_get_slid(hdr)
> |
> -( ( be32_to_cpu ( ohdr -> u . ud . deth [ 1 ] ) ) & IB_QPN_MASK )
> +ib_get_sqpn(ohdr)
> |
> -get_unaligned_be64 ( p )
> +ib_u64_get(p)
> |
> -container_of ( x_ibdev , struct rvt_dev_info , x_ibdev )
> +ib_to_rvt(x_ibdev)
> |
> -container_of ( ibah , struct rvt_ah , ibah )
> +ibah_to_rvtah(ibah)
> |
> -container_of ( ibpd , struct rvt_pd , ibpd )
> +ibpd_to_rvtpd(ibpd)
> |
> -dev_name ( & rdi -> ibdev . dev )
> +rvt_get_ibdev_name(rdi)
> |
> -rdi -> dparms . npkeys
> +rvt_get_npkeys(rdi)
> |
> -rdi -> dparms . max_rdma_atomic + rdi -> dparms . extra_rdma_atomic + 1
> +rvt_max_atomic(rdi)
> |
> -rdi -> dparms . max_rdma_atomic + rdi -> dparms . extra_rdma_atomic
> +rvt_size_atomic(rdi)
> |
> -umem_odp -> notifier . interval_tree . last + 1
> +ib_umem_end(umem_odp)
> |
> -( ib_umem_end ( umem_odp ) - ib_umem_start ( umem_odp ) ) >> umem_odp -=
> page_shift
> +ib_umem_odp_num_pages(umem_odp)
> |
> -umem_odp -> notifier . interval_tree . start
> +ib_umem_start(umem_odp)
> |
> -container_of ( umem , struct ib_umem_odp , umem )
> +to_ib_umem_odp(umem)
> |
> -( ( be64_to_cpu ( gid -> global . interface_id ) >> 40 ) =3D=3D OPA_SPE=
CIAL_OUI )
> +ib_is_opa_gid(gid)
> |
> -be64_to_cpu ( gid -> global . interface_id ) & 0xFFFFFFFF
> +opa_get_lid_from_gid(gid)
> |
> -( be32_to_cpu ( OPA_LID_PERMISSIVE ) << ( 32 - nr_top_bits ) )
> +opa_get_mcast_base(nr_top_bits)
> // |
> // - - EINVAL
> // +_uverbs_get_const(to, attrs_bundle, idx, lower_bound, upper_bound, d=
ef_val)
> |
> -ib_uverbs_get_ucontext_file ( x_attrs -> ufile )
> +ib_uverbs_get_ucontext(x_attrs)
> |
> -container_of ( udata , struct uverbs_attr_bundle , driver_udata )
> +rdma_udata_to_uverbs_attr_bundle(udata)
> |
> -attr_key - 1
> +uapi_bkey_attr(attr_key)
> |
> -attr_bkey + 1
> +uapi_bkey_to_key_attr(attr_bkey)
> |
> -attr_key & ( UVERBS_API_OBJ_KEY_MASK | UVERBS_API_METHOD_KEY_MASK )
> +uapi_key_attr_to_ioctl_method(attr_key)
> |
> -ioctl_method_key + 1
> +uapi_key_attrs_start(ioctl_method_key)
> |
> -( key & ~ UVERBS_API_OBJ_KEY_MASK ) =3D=3D 0
> +uapi_key_is_object(key)
> |
> -( key & UVERBS_API_METHOD_KEY_MASK ) =3D=3D UVERBS_API_METHOD_IS_WRITE_=
EX
> +uapi_key_is_write_ex_method(key)
> |
> -( key & UVERBS_API_METHOD_KEY_MASK ) =3D=3D UVERBS_API_METHOD_IS_WRITE
> +uapi_key_is_write_method(key)
> |
> -test_bit ( uapi_bkey_attr ( uapi_key_attr ( idx ) ) , attrs_bundle -> a=
ttr_present )
> +uverbs_attr_is_valid(attrs_bundle, idx)
> |
> -x_attr -> ptr_attr . len <=3D sizeof ( x_attr -> ptr_attr . data )
> +uverbs_attr_ptr_is_inline(x_attr)
> |
> -uverbs_get_const_signed ( to , attrs_bundle , idx )
> +uverbs_get_raw_fd(to, attrs_bundle, idx)
> |
> -( ( a -> sib_addr64 [ 0 ] | a -> sib_addr64 [ 1 ] ) =3D=3D 0 )
> +ib_addr_any(a)
> |
> -( ( a -> sib_addr32 [ 0 ] | a -> sib_addr32 [ 1 ] | a -> sib_addr32 [ 2=
 ] | ( a -> sib_addr32 [ 3 ] ^ htonl ( 1 ) ) ) =3D=3D 0 )
> +ib_addr_loopback(a)
> |
> -filp -> f_cred =3D=3D current_cred ( )
> +ib_safe_file_access(filp)
> )
>=20
>=20
> 153 branches
>=20
>=20
> Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/janit=
or> time /usr/bin/spatch --parse-cocci /home/altes_Heim2/elfring/Projekte/=
Bau/Linux/scripts/Coccinelle/list_inline_non-void_functions5-rdma-adjusted=
-20251114.cocci
> =E2=80=A6
> pure metavariable T is matched against the following nonpure code:
> struct rvt_swqe=20
>=20
>=20
> No grep query
>=20
> real    0m24,940s
> user    0m24,241s
> sys     0m0,362s
>=20
>=20
> How will software improvements evolve accordingly?
The following information can be determined from the application
of the software combination =E2=80=9CCoccinelle 1.3.2=E2=80=9D.


Markus_Elfring@Sonne:~> time spatch --parse-cocci /home/altes_Heim2/elfrin=
g/Projekte/Bau/Linux/scripts/Coccinelle/list_inline_non-void_functions5-rd=
ma-adjusted-20251114.cocci
=E2=80=A6
No grep query

real    0m46,834s
user    0m45,685s
sys     0m0,314s


Regards,
Markus
