From: nicstange@gmail.com (Nicolai Stange)
Date: Sun, 14 Feb 2016 02:31:08 +0100
Subject: [Cocci] [PATCH v3 0/7] fix debugfs file removal races
Message-ID: <87k2m8krhf.fsf@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Original v2 thread is here:

  http://lkml.kernel.org/g/87fux3memd.fsf at gmail.com

In the discussion of v2, it turned out that touching each and every of
the ~1000 debugfs users in order to make them save against file
removals is unfeasible.

Thus, v3 takes a different approach: every struct file_operations
handed to debugfs is wrapped by a protecting proxy in [2/7].  Only
those struct file_operations which are easy to fix directly,
i.e. those defined by debugfs itself, opt-out from this proxying in
[3-7/7].


The Coccinelle people are CC'd because of [3/7].
Many thanks to J. Lawall who helped me very much at #cocci at freenode
in getting this done!


The SRCU part really needs some fresh review: in v2 the
rcu_assign_pointer()'ed and srcu_derefence()'d ->d_fsdata has been
effectively used as an indication of whether a file is dead or not.

With the full proxy approach in v3, ->d_fsdata can't be cleared out at
file removal because open files might still hold a reference to it and
those must be released again from the proxy's ->release().

Thus, the properly memory- and compiler-barriered accesses to
->d_fsdata have now been replaced by completely unbarriered d_delete()
and d_unlinked() calls in debugfs_use_file_start() and
debugfs_remove() (all in [1/7] now).

I believe that no extra barriers are needed:
The SRCU read side critical sections around any file usage looks like this:
    srcu_read_lock();
    if(d_unlinked(dentry)) {
      srcu_read_unlock();
      return -EIO
    }
    cope_around_with(d_inode(dentry)->i_private);
    srcu_read_unlock()
- srcu_read_lock() and srcu_read_unlock() already contain a barrier()
  each. Thus, the compiler is forced to make the dentry's state being
  read at least once within the read side critical section.  
- I don't care for speculative reads to the file's private data
  in cope_around_with().
- Writes in cope_around_with() should be properly handled by the control
  dependency in that they don't occur on the bus if d_unlinked() holds.
  Furthermore, any writes in cope_around_with() are emitted by the
  compiler before the srcu_read_unlock().

For the file removing side of things, the SRCU usage looks like this:
  d_delete(dentry);
  synchronize_srcu();
  free(d_inode(dentry)->i_private);
d_delete() is defined in another compilation unit. Thus, its call can't be
reorded with the one to synchronize_srcu() and the dentry state is written
(on that CPU) before synchronize_srcu() is entered.


Changes v2 -> v3:
  [1/7] ("debugfs: prevent access to possibly dead file_operations at file open")
   - move the definition of the debugfs_use_file_start() and _end() from former
     [2/2] to [1/7]. Also, they've been renamed from debugfs_file_use_data*().
   - Make the ->open() proxy use the debugfs_use_file_*() helpers.
   - In debugfs_use_file_start(), use d_unlinked() rather than
     (->d_fsdata == NULL) as a flag whether the dentry is dead.
   - Make the ->open() proxy include the forwarded call to the original fops' ->open
     within the SRCU read side critical section.
   - debugfs_proxy_file_operations has been renamed to
     "debugfs_open_proxy_file_operations"  to distinguish it from the full proxy
     introduced in [2/7].

  [2/7] ("debugfs: prevent access to removed files' private data")
   - This one has changed completely: instead of providing file
     removal-safe fops helpers to opt-into at the debugfs users, the
     original struct file_operations get completely and
     unconditionally proxied now.

  [3-7/7]
   New. Opt-out from the full proxying introduced in [2/7] for some
   special case struct file_operations provided by debugfs itself.


Changes v1 -> v2:
  [1/2] ("debugfs: prevent access to possibly dead file_operations at file open")
   - Resolve trivial diff conflict in debugfs_remove_recursive():
     in the meanwhile, an unrelated 'mutex_unlock(...)' had been rewritten to
     'inode_unlock(...)' which broke the diff's context.
   - Introduce the fs/debugfs/internal.h header and move the declarations of
     debugfs_noop_file_operations, debugfs_proxy_file_operations and
     debugfs_rcu from include/linux/debugfs.h thereinto. Include this header
     from file.c and inode.c.
   - Add a word about the new internal header to the commit message.
   - Move the inclusion of linux/srcu.h from include/linux/debugfs.h
     into file.c and inode.c respectively.

  [2/2] ("debugfs: prevent access to removed files' private data")
   - Move the definitions of debugfs_file_use_data_start() and
     debugfs_file_use_data_finish() from include/linux/debugfs.h to
     file.c. Export them and keep their declarations in debugfs.h,
   - In order to be able to attach proper __acquires() and __releases() tags
     to the decalarations of debugfs_file_use_data_*() in debugfs.h,
     move the debugfs_srcu declaration from internal.h into debugfs.h.
   - Since the definitions as well as the docstrings of
     debugfs_file_use_data_*() have been moved into file.c,
     there is no need to run DocBook on debugfs.h: do not modify
     Documentation/DocBook/filesystems.tmpl anymore.
   - In the commit message, encourage new users of debugfs to prefer
     DEFINE_DEBUGFS_ATTRIBUTE() and friends over DEFINE_SIMPLE_ATTRIBUTE().

Nicolai Stange (7):
  debugfs: prevent access to possibly dead file_operations at file open
  debugfs: prevent access to removed files' private data
  debugfs: add support for self-protecting attribute file fops
  debugfs: unproxify attribute files created through
    debugfs_create_XXX()
  debugfs: unproxify files created through debugfs_create_bool()
  debugfs: unproxify files created through debugfs_create_blob()
  debugfs: unproxify files created through debugfs_create_u32_array()

 fs/debugfs/file.c                                  | 437 +++++++++++++++++----
 fs/debugfs/inode.c                                 | 101 ++++-
 fs/debugfs/internal.h                              |  26 ++
 include/linux/debugfs.h                            |  47 ++-
 lib/Kconfig.debug                                  |   1 +
 .../api/debugfs/debugfs_simple_attr.cocci          |  68 ++++
 6 files changed, 592 insertions(+), 88 deletions(-)
 create mode 100644 fs/debugfs/internal.h
 create mode 100644 scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

-- 
2.7.1
