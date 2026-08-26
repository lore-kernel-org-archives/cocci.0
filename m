Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4B8C5DF97
	for <cocci@archiver.kernel.org>; Wed, 26 Aug 2026 10:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=lo4z8YUiApSseIj7VH70LyS4PYNANtboHhxc8TPkcGk=;
  b=UFnS9ZpZFp6LmJxpXzsrFIKn764BYnsloX0n7ilsRAQyM82g4tCCqEvo
   ajoSe2BTOpgFeVRqsXtaEFJxAFY1uM44Se46+nU38yrFopOsmeNugSP43
   22ARi9qeSqkTwBvyUbBdA9tSwVlnoTByym3vrCsU9pa9aHrJYvalZOLcS
   A=;
X-CSE-ConnectionGUID: o5kxVKEgSy2JW0MtqsrgWw==
X-CSE-MsgGUID: 39B4AWc7QzmzMFTF0CSAWw==
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
   d="scan'208";a="291620550"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Aug 2026 12:58:33 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6ADB88051A; Wed, 26 Aug 2026 12:58:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 18D4E80288
	for <cocci@sympa.inria.fr>; Wed, 26 Aug 2026 12:58:30 +0200 (CEST)
X-CSE-ConnectionGUID: 6kMznGzrRW6MzbPEzaI/ew==
X-CSE-MsgGUID: IMUR1lFDRfGCzxPy3PWOAQ==
X-IronPort-AV: E=Sophos;i="6.25,244,1779141600"; 
   d="scan'208";a="291620536"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 12:58:30 +0200
Date: Wed, 26 Aug 2026 12:58:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <251ea667-c8b8-4d71-9397-86835c1dcf88@web.de>
Message-ID: <ecc52714-2998-6846-21a-bed28a3b4f81@inria.fr>
References: <95c4aa23-d13d-4ec3-89a8-5df56844addf@web.de> <acc76ef2-2a0-f716-ff28-f8be945db26d@inria.fr> <0fbe54d4-d595-4fcc-bba7-14da44ca3f0d@web.de> <3f2a4432-375d-4a93-ba53-11006d0c2fd6@web.de> <b7cba424-69d9-5534-85dd-e3cf5098e4af@inria.fr>
 <a6f6fee5-d935-48eb-82b0-63e202f25529@web.de> <eac84dab-f980-a9fd-e37c-b8259140b4ed@inria.fr> <5b9536bb-5a8f-436f-9dd4-9d0ffe34c4a3@web.de> <5acea20e-16ce-4d49-98ce-79a3f7beae4c@web.de> <251ea667-c8b8-4d71-9397-86835c1dcf88@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-470666611-1787741910=:18000"
Subject: Re: [cocci] Checking run time characteristics for longer SmPL
 disjunctions?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3714
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/h8ZjGBeYmNX0Cx6rmwKw-g>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-470666611-1787741910=:18000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 26 Aug 2026, Markus Elfring wrote:

> >> Do they trigger desirable grep queries?
> >
> > I would like to share some data from another test run.
> > https://elixir.bootlin.com/linux/v6.18-rc5/source/include/rdma

Did you try just not using a disjunction?

julia

> >
> > Generated SmPL script (with some tweaks):
> > @replacements@
> > expression a, access_flags, ateth, attr_bkey, attr_key, attrs_bundle, b, biter, bundle, client, comp_vector, cpi, cq, def_val, dest, dev_addr, direction, dma_addr, entry, filp, flags, gid, hdr, ibah, ibcq, ibpd, ibqp, ibsrq, idx, init_attr, ioctl_method_key, key, lower_bound, mr, n, nents, net_dev, nr_cqe, nr_top_bits, num_entries, offset, ohdr, p, pd, pgoff, pgoff_bitmask, pgsz, pgsz_bitmap, poll_ctx, port, private, ptr, qp, rdi, rec, res, reth, rmpp_hdr, rq, sg, size, smp, src, srq_type, swqe, to, ucontext, udata, umem, umem_odp, uobj, upper_bound, wc, x_attr, x_attrs, x_dev, x_device, x_ibdev, x_len, x_length, x_port_num, x_wr;
> > typedef u8, u16, u32, u64, uintptr_t;
> > @@
> > (
> > -! ! ( x_device -> attrs . kernel_cap_flags & IBK_RDMA_NETDEV_OPA )
> > +rdma_cap_opa_vnic(x_device)
> > |
> > -uobj -> uapi_object -> id
> > +uobj_get_object_id(uobj)
> > |
> > -! res -> user
> > +rdma_is_kernel_res(res)
> > |
> > -! res -> no_track
> > +rdma_restrack_is_tracked(res)
> > |
> > -( u8 ) ( be32_to_cpu ( cpi -> cap_mask2_resp_time ) & IB_CLASS_PORT_INFO_RESP_TIME_MASK )
> > +ib_get_cpi_resp_time(cpi)
> > |
> > -rmpp_hdr -> rmpp_rtime_flags & 0x7
> > +ib_get_rmpp_flags(rmpp_hdr)
> > |
> > -rmpp_hdr -> rmpp_rtime_flags >> 3
> > +ib_get_rmpp_resptime(rmpp_hdr)
> > |
> > -( ( smp -> status & IB_SMP_DIRECTION ) == IB_SMP_DIRECTION )
> > +ib_get_smp_direction(smp)
> > |
> > -be16_to_cpu ( * ptr )
> > +_iba_get16(ptr)
> > |
> > -be32_to_cpu ( * ptr )
> > +_iba_get32(ptr)
> > |
> > -be64_to_cpu ( get_unaligned ( ptr ) )
> > +_iba_get64(ptr)
> > |
> > - * ptr
> > +_iba_get8(ptr)
> > |
> > -ib_get_smp_direction ( ( struct ib_smp * ) smp )
> > +opa_get_smp_direction(smp)
> > |
> > -container_of ( ibqp , struct rvt_qp , ibqp )
> > +ibqp_to_rvtqp(ibqp)
> > |
> > -container_of ( ibsrq , struct rvt_srq , ibsrq )
> > +ibsrq_to_rvtsrq(ibsrq)
> > |
> > -( ( ( int ) a ) - ( ( int ) b ) ) << 8
> > +rvt_cmp_msn(a, b)
> > |
> > -x_len >> qp -> log_pmtu
> > +rvt_div_mtu(qp, x_len)
> > |
> > -( x_len + qp -> pmtu - 1 ) >> qp -> log_pmtu
> > +rvt_div_round_up_mtu(qp, x_len)
> > |
> > -( struct rvt_rwqe * ) ( ( char * ) rq -> kwq -> curr_wq + ( sizeof ( struct rvt_rwqe ) + rq -> max_sge * sizeof ( struct ib_sge ) ) * n )
> > +rvt_get_rwqe_ptr(rq, n)
> > |
> > -ibah_to_rvtah ( swqe -> ud_wr . wr . ah )
> > +rvt_get_swqe_ah(swqe)
> > |
> > -swqe -> ud_wr . attr
> > +rvt_get_swqe_ah_attr(swqe)
> > |
> > -swqe -> ud_wr . wr . pkey_index
> > +rvt_get_swqe_pkey_index(swqe)
> > |
> > -( struct rvt_swqe * ) ( ( char * ) qp -> s_wq + ( sizeof ( struct rvt_swqe ) + qp -> s_max_sge * sizeof ( struct rvt_sge ) ) * n )
> > +rvt_get_swqe_ptr(qp, n)
> > |
> > -swqe -> ud_wr . wr . remote_qkey
> > +rvt_get_swqe_remote_qkey(swqe)
> > |
> > -swqe -> ud_wr . wr . remote_qpn
> > +rvt_get_swqe_remote_qpn(swqe)
> > |
> > -! ! qp -> pid
> > +rvt_is_user_qp(qp)
> > |
> > -( ( u16 ) dev_addr -> broadcast [ 8 ] << 8 ) | ( u16 ) dev_addr -> broadcast [ 9 ]
> > +ib_addr_get_pkey(dev_addr)
> > |
> > -dev_addr -> dev_type == ARPHRD_INFINIBAND ? 4 : 0
> > +rdma_addr_gid_offset(dev_addr)
> > |
> > -is_vlan_dev ( x_dev ) ? vlan_dev_real_dev ( x_dev ) : NULL
> > +rdma_vlan_dev_real_dev(x_dev)
> > |
> > -is_vlan_dev ( x_dev ) ? vlan_dev_vlan_id ( x_dev ) : 0xffff
> > +rdma_vlan_dev_vlan_id(x_dev)
> > |
> > -container_of ( x_wr , struct ib_atomic_wr , x_wr )
> > +atomic_wr(x_wr)
> > |
> > -access_flags & ( IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_ATOMIC | IB_ACCESS_MW_BIND )
> > +ib_access_writable(access_flags)
> > |
> > -__ib_alloc_cq ( x_dev , private , nr_cqe , comp_vector , poll_ctx , KBUILD_MODNAME )
> > +ib_alloc_cq(x_dev, private, nr_cqe, comp_vector, poll_ctx)
> > |
> > -__ib_alloc_cq_any ( x_dev , private , nr_cqe , poll_ctx , KBUILD_MODNAME )
> > +ib_alloc_cq_any(x_dev, private, nr_cqe, poll_ctx)
> > |
> > -copy_from_user ( dest , udata -> inbuf , x_len ) ? - EFAULT : 0
> > +ib_copy_from_udata(dest, udata, x_len)
> > |
> > -copy_to_user ( udata -> outbuf , src , x_len ) ? - EFAULT : 0
> > +ib_copy_to_udata(udata, src, x_len)
> > |
> > -ib_create_qp_kernel ( pd , init_attr , KBUILD_MODNAME )
> > +ib_create_qp(pd, init_attr)
> > |
> > -ib_dereg_mr_user ( mr , NULL )
> > +ib_dereg_mr(mr)
> > |
> > -ib_destroy_qp_user ( qp , NULL )
> > +ib_destroy_qp(qp)
> > |
> > -refcount_inc_not_zero ( & x_dev -> refcount )
> > +ib_device_try_get(x_dev)
> > |
> > -ib_dma_map_sg_attrs ( x_dev , sg , nents , direction , 0 )
> > +ib_dma_map_sg(x_dev, sg, nents, direction)
> > |
> > -xa_load ( & x_device -> client_data , client -> client_id )
> > +ib_get_client_data(x_device, client)
> > |
> > -( netif_running ( net_dev ) && netif_carrier_ok ( net_dev ) ) ? IB_PORT_ACTIVE : IB_PORT_DOWN
> > +ib_get_curr_port_state(net_dev)
> > |
> > -ib_is_buffer_cleared ( udata -> inbuf + offset , x_len )
> > +ib_is_udata_cleared(udata, offset, x_len)
> > |
> > -cq -> device -> ops . poll_cq ( cq , num_entries , wc )
> > +ib_poll_cq(cq, num_entries, wc)
> > |
> > -cq -> device -> ops . req_notify_cq ( cq , flags )
> > +ib_req_notify_cq(cq, flags)
> > |
> > -srq_type == IB_SRQT_XRC || srq_type == IB_SRQT_TM
> > +ib_srq_has_cq(srq_type)
> > |
> > -IS_ENABLED ( CONFIG_INFINIBAND_VIRT_DMA ) && ! x_dev -> dma_device
> > +ib_uses_virt_dma(x_dev)
> > |
> > -virt_to_page ( ib_virt_dma_to_ptr ( dma_addr ) )
> > +ib_virt_dma_to_page(dma_addr)
> > |
> > -( void * ) ( uintptr_t ) dma_addr
> > +ib_virt_dma_to_ptr(dma_addr)
> > |
> > -x_attr -> ah_flags
> > +rdma_ah_get_ah_flags(x_attr)
> > |
> > -x_attr -> port_num
> > +rdma_ah_get_port_num(x_attr)
> > |
> > -x_attr -> sl
> > +rdma_ah_get_sl(x_attr)
> > |
> > -x_attr -> static_rate
> > +rdma_ah_get_static_rate(x_attr)
> > |
> > -biter -> __dma_addr & ~ ( BIT_ULL ( biter -> __pg_bit ) - 1 )
> > +rdma_block_iter_dma_address(biter)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_AF_IB
> > +rdma_cap_af_ib(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_ETH_AH
> > +rdma_cap_eth_ah(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_IB_CM
> > +rdma_cap_ib_cm(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_IB_MAD
> > +rdma_cap_ib_mad(x_device, x_port_num)
> > |
> > -rdma_cap_ib_sa ( x_device , x_port_num )
> > +rdma_cap_ib_mcast(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_IB_SA
> > +rdma_cap_ib_sa(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_IB_SMI
> > +rdma_cap_ib_smi(x_device, x_port_num)
> > |
> > -x_device -> is_switch
> > +rdma_cap_ib_switch(x_device)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_IW_CM
> > +rdma_cap_iw_cm(x_device, x_port_num)
> > |
> > -( x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_OPA_AH ) == RDMA_CORE_CAP_OPA_AH
> > +rdma_cap_opa_ah(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_OPA_MAD
> > +rdma_cap_opa_mad(x_device, x_port_num)
> > |
> > -rdma_protocol_iwarp ( x_dev , x_port_num )
> > +rdma_cap_read_inv(x_dev, x_port_num)
> > |
> > -rdma_protocol_roce ( x_device , x_port_num ) && x_device -> ops . add_gid && x_device -> ops . del_gid
> > +rdma_cap_roce_gid_table(x_device, x_port_num)
> > |
> > -( x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_PORT_INTEL_OPA ) == RDMA_CORE_PORT_INTEL_OPA
> > +rdma_core_cap_opa_port(x_device, x_port_num)
> > |
> > -read_pnet ( & x_device -> coredev . rdma_net )
> > +rdma_dev_net(x_device)
> > |
> > -rdma_cap_ib_switch ( x_device ) ? 0 : x_device -> phys_port_cnt
> > +rdma_end_port(x_device)
> > |
> > -rdma_protocol_ib ( x_device , x_port_num ) || rdma_protocol_roce ( x_device , x_port_num )
> > +rdma_ib_or_roce(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_PORT_IB_GRH_REQUIRED
> > +rdma_is_grh_required(x_device, x_port_num)
> > |
> > -( port >= rdma_start_port ( x_device ) && port <= rdma_end_port ( x_device ) )
> > +rdma_is_port_valid(x_device, port)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . max_mad_size
> > +rdma_max_mad_size(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_PROT_IB
> > +rdma_protocol_ib(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_PROT_IWARP
> > +rdma_protocol_iwarp(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_PROT_RAW_PACKET
> > +rdma_protocol_raw_packet(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & ( RDMA_CORE_CAP_PROT_ROCE | RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP )
> > +rdma_protocol_roce(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_PROT_ROCE
> > +rdma_protocol_roce_eth_encap(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP
> > +rdma_protocol_roce_udp_encap(x_device, x_port_num)
> > |
> > -x_device -> port_data [ x_port_num ] . immutable . core_cap_flags & RDMA_CORE_CAP_PROT_USNIC
> > +rdma_protocol_usnic(x_device, x_port_num)
> > |
> > -rdma_cap_ib_switch ( x_device ) ? 0 : 1
> > +rdma_start_port(x_device)
> > |
> > -rdma_user_mmap_entry_insert_range ( ucontext , entry , x_length , pgoff , pgoff )
> > +rdma_user_mmap_entry_insert_exact(ucontext, entry, x_length, pgoff)
> > |
> > -( u64 ) entry -> start_pgoff << PAGE_SHIFT
> > +rdma_user_mmap_get_offset(entry)
> > |
> > -container_of ( x_wr , struct ib_rdma_wr , x_wr )
> > +rdma_wr(x_wr)
> > |
> > -container_of ( x_wr , struct ib_reg_wr , x_wr )
> > +reg_wr(wr)
> > |
> > -container_of ( x_wr , struct ib_ud_wr , x_wr )
> > +ud_wr(x_wr)
> > |
> > -__rdma_block_iter_next ( biter ) && biter -> __sg_numblocks --
> > +__rdma_umem_block_iter_next(biter)
> > |
> > -ib_umem_start_dma_addr ( umem ) & ( pgsz - 1 )
> > +ib_umem_dma_offset(umem, pgsz)
> > // |
> > // -0
> > // +ib_umem_find_best_pgoff(umem, pgsz_bitmap, pgoff_bitmask)
> > |
> > -( size_t ) ( ( ALIGN ( umem -> iova + umem -> length , pgsz ) - ALIGN_DOWN ( umem -> iova , pgsz ) ) ) / pgsz
> > +ib_umem_num_dma_blocks(umem, pgsz)
> > |
> > -ib_umem_num_dma_blocks ( umem , PAGE_SIZE )
> > +ib_umem_num_pages(umem)
> > |
> > -umem -> address & ~ PAGE_MASK
> > +ib_umem_offset(umem)
> > |
> > -sg_dma_address ( umem -> sgt_append . sgt . sgl ) + ib_umem_offset ( umem )
> > +ib_umem_start_dma_addr(umem)
> > |
> > -container_of ( umem , struct ib_umem_dmabuf , umem )
> > +to_ib_umem_dmabuf(umem)
> > |
> > -( rec -> rec_type == SA_PATH_REC_TYPE_OPA )
> > +sa_path_is_opa(rec)
> > |
> > -( ( rec -> rec_type == SA_PATH_REC_TYPE_ROCE_V1 ) || ( rec -> rec_type == SA_PATH_REC_TYPE_ROCE_V2 ) )
> > +sa_path_is_roce(rec)
> > |
> > -container_of ( ibcq , struct rvt_cq , ibcq )
> > +ibcq_to_rvtcq(ibcq)
> > |
> > -ib_u64_get ( & ateth -> compare_data )
> > +get_ib_ateth_compare(ateth)
> > |
> > -ib_u64_get ( & ateth -> swap_data )
> > +get_ib_ateth_swap(ateth)
> > |
> > -ib_u64_get ( & ateth -> vaddr )
> > +get_ib_ateth_vaddr(ateth)
> > |
> > -ib_u64_get ( & reth -> vaddr )
> > +get_ib_reth_vaddr(reth)
> > |
> > -( u8 ) ( ( be32_to_cpu ( ohdr -> bth [ 2 ] ) >> IB_BTH_A_SHIFT ) & IB_BTH_A_MASK )
> > +ib_bth_get_ackreq(ohdr)
> > |
> > -( ohdr -> bth [ 1 ] ) & cpu_to_be32 ( IB_BECN_SMASK )
> > +ib_bth_get_becn(ohdr)
> > |
> > -( ohdr -> bth [ 1 ] ) & cpu_to_be32 ( IB_FECN_SMASK )
> > +ib_bth_get_fecn(ohdr)
> > |
> > -( u8 ) ( ( be32_to_cpu ( ohdr -> bth [ 0 ] ) >> IB_BTH_M_SHIFT ) & IB_BTH_M_MASK )
> > +ib_bth_get_migreq(ohdr)
> > |
> > -( ( be32_to_cpu ( ohdr -> bth [ 0 ] ) >> IB_BTH_OPCODE_SHIFT ) & IB_BTH_OPCODE_MASK )
> > +ib_bth_get_opcode(ohdr)
> > |
> > -( ( be32_to_cpu ( ohdr -> bth [ 0 ] ) >> IB_BTH_PAD_SHIFT ) & IB_BTH_PAD_MASK )
> > +ib_bth_get_pad(ohdr)
> > |
> > -( be32_to_cpu ( ohdr -> bth [ 0 ] ) & IB_BTH_PKEY_MASK )
> > +ib_bth_get_pkey(ohdr)
> > |
> > -( u32 ) ( be32_to_cpu ( ohdr -> bth [ 2 ] ) )
> > +ib_bth_get_psn(ohdr)
> > |
> > -( u32 ) ( ( be32_to_cpu ( ohdr -> bth [ 1 ] ) ) & IB_QPN_MASK )
> > +ib_bth_get_qpn(ohdr)
> > |
> > -( u8 ) ( ( be32_to_cpu ( ohdr -> bth [ 0 ] ) >> IB_BTH_SE_SHIFT ) & IB_BTH_SE_MASK )
> > +ib_bth_get_se(ohdr)
> > |
> > -( u8 ) ( ( be32_to_cpu ( ohdr -> bth [ 0 ] ) >> IB_BTH_TVER_SHIFT ) & IB_BTH_TVER_MASK )
> > +ib_bth_get_tver(ohdr)
> > |
> > -ohdr -> bth [ 0 ] & cpu_to_be32 ( IB_BTH_MIG_REQ )
> > +ib_bth_is_migration(ohdr)
> > |
> > -ohdr -> bth [ 0 ] & cpu_to_be32 ( IB_BTH_SOLICITED )
> > +ib_bth_is_solicited(ohdr)
> > |
> > -( be16_to_cpu ( hdr -> lrh [ 1 ] ) )
> > +ib_get_dlid(hdr)
> > |
> > -( be16_to_cpu ( hdr -> lrh [ 0 ] ) & IB_LNH_MASK )
> > +ib_get_lnh(hdr)
> > |
> > -( u8 ) ( ( be16_to_cpu ( hdr -> lrh [ 0 ] ) >> IB_LVER_SHIFT ) & IB_LVER_MASK )
> > +ib_get_lver(hdr)
> > |
> > -be32_to_cpu ( ohdr -> u . ud . deth [ 0 ] )
> > +ib_get_qkey(ohdr)
> > |
> > -( ( be16_to_cpu ( hdr -> lrh [ 0 ] ) >> IB_SC_SHIFT ) & IB_SC_MASK )
> > +ib_get_sc(hdr)
> > |
> > -( ( be16_to_cpu ( hdr -> lrh [ 0 ] ) >> IB_SL_SHIFT ) & IB_SL_MASK )
> > +ib_get_sl(hdr)
> > |
> > -( be16_to_cpu ( hdr -> lrh [ 3 ] ) )
> > +ib_get_slid(hdr)
> > |
> > -( ( be32_to_cpu ( ohdr -> u . ud . deth [ 1 ] ) ) & IB_QPN_MASK )
> > +ib_get_sqpn(ohdr)
> > |
> > -get_unaligned_be64 ( p )
> > +ib_u64_get(p)
> > |
> > -container_of ( x_ibdev , struct rvt_dev_info , x_ibdev )
> > +ib_to_rvt(x_ibdev)
> > |
> > -container_of ( ibah , struct rvt_ah , ibah )
> > +ibah_to_rvtah(ibah)
> > |
> > -container_of ( ibpd , struct rvt_pd , ibpd )
> > +ibpd_to_rvtpd(ibpd)
> > |
> > -dev_name ( & rdi -> ibdev . dev )
> > +rvt_get_ibdev_name(rdi)
> > |
> > -rdi -> dparms . npkeys
> > +rvt_get_npkeys(rdi)
> > |
> > -rdi -> dparms . max_rdma_atomic + rdi -> dparms . extra_rdma_atomic + 1
> > +rvt_max_atomic(rdi)
> > |
> > -rdi -> dparms . max_rdma_atomic + rdi -> dparms . extra_rdma_atomic
> > +rvt_size_atomic(rdi)
> > |
> > -umem_odp -> notifier . interval_tree . last + 1
> > +ib_umem_end(umem_odp)
> > |
> > -( ib_umem_end ( umem_odp ) - ib_umem_start ( umem_odp ) ) >> umem_odp -> page_shift
> > +ib_umem_odp_num_pages(umem_odp)
> > |
> > -umem_odp -> notifier . interval_tree . start
> > +ib_umem_start(umem_odp)
> > |
> > -container_of ( umem , struct ib_umem_odp , umem )
> > +to_ib_umem_odp(umem)
> > |
> > -( ( be64_to_cpu ( gid -> global . interface_id ) >> 40 ) == OPA_SPECIAL_OUI )
> > +ib_is_opa_gid(gid)
> > |
> > -be64_to_cpu ( gid -> global . interface_id ) & 0xFFFFFFFF
> > +opa_get_lid_from_gid(gid)
> > |
> > -( be32_to_cpu ( OPA_LID_PERMISSIVE ) << ( 32 - nr_top_bits ) )
> > +opa_get_mcast_base(nr_top_bits)
> > // |
> > // - - EINVAL
> > // +_uverbs_get_const(to, attrs_bundle, idx, lower_bound, upper_bound, def_val)
> > |
> > -ib_uverbs_get_ucontext_file ( x_attrs -> ufile )
> > +ib_uverbs_get_ucontext(x_attrs)
> > |
> > -container_of ( udata , struct uverbs_attr_bundle , driver_udata )
> > +rdma_udata_to_uverbs_attr_bundle(udata)
> > |
> > -attr_key - 1
> > +uapi_bkey_attr(attr_key)
> > |
> > -attr_bkey + 1
> > +uapi_bkey_to_key_attr(attr_bkey)
> > |
> > -attr_key & ( UVERBS_API_OBJ_KEY_MASK | UVERBS_API_METHOD_KEY_MASK )
> > +uapi_key_attr_to_ioctl_method(attr_key)
> > |
> > -ioctl_method_key + 1
> > +uapi_key_attrs_start(ioctl_method_key)
> > |
> > -( key & ~ UVERBS_API_OBJ_KEY_MASK ) == 0
> > +uapi_key_is_object(key)
> > |
> > -( key & UVERBS_API_METHOD_KEY_MASK ) == UVERBS_API_METHOD_IS_WRITE_EX
> > +uapi_key_is_write_ex_method(key)
> > |
> > -( key & UVERBS_API_METHOD_KEY_MASK ) == UVERBS_API_METHOD_IS_WRITE
> > +uapi_key_is_write_method(key)
> > |
> > -test_bit ( uapi_bkey_attr ( uapi_key_attr ( idx ) ) , attrs_bundle -> attr_present )
> > +uverbs_attr_is_valid(attrs_bundle, idx)
> > |
> > -x_attr -> ptr_attr . len <= sizeof ( x_attr -> ptr_attr . data )
> > +uverbs_attr_ptr_is_inline(x_attr)
> > |
> > -uverbs_get_const_signed ( to , attrs_bundle , idx )
> > +uverbs_get_raw_fd(to, attrs_bundle, idx)
> > |
> > -( ( a -> sib_addr64 [ 0 ] | a -> sib_addr64 [ 1 ] ) == 0 )
> > +ib_addr_any(a)
> > |
> > -( ( a -> sib_addr32 [ 0 ] | a -> sib_addr32 [ 1 ] | a -> sib_addr32 [ 2 ] | ( a -> sib_addr32 [ 3 ] ^ htonl ( 1 ) ) ) == 0 )
> > +ib_addr_loopback(a)
> > |
> > -filp -> f_cred == current_cred ( )
> > +ib_safe_file_access(filp)
> > )
> >
> >
> > 153 branches
> >
> >
> > Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/janitor> time /usr/bin/spatch --parse-cocci /home/altes_Heim2/elfring/Projekte/Bau/Linux/scripts/Coccinelle/list_inline_non-void_functions5-rdma-adjusted-20251114.cocci
> > …
> > pure metavariable T is matched against the following nonpure code:
> > struct rvt_swqe
> >
> >
> > No grep query
> >
> > real    0m24,940s
> > user    0m24,241s
> > sys     0m0,362s
> >
> >
> > How will software improvements evolve accordingly?
> The following information can be determined from the application
> of the software combination “Coccinelle 1.3.2”.
>
>
> Markus_Elfring@Sonne:~> time spatch --parse-cocci /home/altes_Heim2/elfring/Projekte/Bau/Linux/scripts/Coccinelle/list_inline_non-void_functions5-rdma-adjusted-20251114.cocci
> …
> No grep query
>
> real    0m46,834s
> user    0m45,685s
> sys     0m0,314s
>
>
> Regards,
> Markus
>
--8323329-470666611-1787741910=:18000--
