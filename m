From: nicstange@gmail.com (Nicolai Stange)
Date: Tue, 22 Mar 2016 14:11:12 +0100
Subject: [Cocci] [PATCH v6 0/8] fix debugfs file removal races
Message-ID: <1458652280-19785-1-git-send-email-nicstange@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi Greg,

this series' v6 is meant to replace the v4 currently sitting in your
driver-core tree's driver-core-testing branch.

All the three fixup patches to v4 (not applied anywhere) have been
incorporated into this v6. I'll explicitly mark them as "please drop".


Former v5 thread can be found here:

  http://lkml.kernel.org/g/1457267103-28910-1-git-send-email-nicstange at gmail.com


Applicable to current mainline.


Thanks,

Nicolai


Changes v5 -> v6:
  [1/8] ("debugfs: prevent access to possibly dead file_operations at file open")
   - Fix the double unlock issue found by Rasmus Villemoes and reported
     in reply to v5.


Changes v4 -> v5:
  [1/8] ("debugfs: prevent access to possibly dead file_operations at file open")
   - In the DocBook comment for debugfs_use_file_start(), rename the
     "@file" parameter into the now correct "@dentry".

  [2/8] ("debugfs: prevent access to removed files' private data)"
   - In include/linux/debugfs.h, add the inline keyword to the
     CONFIG_DEBUG_FS=n dummy implementations of
     debugfs_use_file_start()/_finish()

  [3-8/8] unchanged


Changes v3 -> v4:
  [4/8] ("debugfs, coccinelle: check for obsolete DEFINE_SIMPLE_ATTRIBUTE() usage")
   - This one is new, the Coccinelle related changes have been split
     off from former
       [3/7] ("debugfs: add support for self-protecting attribute file fops")
     into this patch.
   - Style fixes as suggested by Julia Lawall have been applied to the
     contained cocci script's comment header.

  [5/8] ("debugfs: unproxify integer attribute files")
   - The commit messages has been reworded in order to get rid of the
     unfortunate triple-X in former [4/7].

  [6-8/8]
   - Former [5-7/8], only the numbering has changed.


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



Nicolai Stange (8):
  debugfs: prevent access to possibly dead file_operations at file open
  debugfs: prevent access to removed files' private data
  debugfs: add support for self-protecting attribute file fops
  debugfs, coccinelle: check for obsolete DEFINE_SIMPLE_ATTRIBUTE()
    usage
  debugfs: unproxify integer attribute files
  debugfs: unproxify files created through debugfs_create_bool()
  debugfs: unproxify files created through debugfs_create_blob()
  debugfs: unproxify files created through debugfs_create_u32_array()

 fs/debugfs/file.c                                  | 436 +++++++++++++++++----
 fs/debugfs/inode.c                                 | 101 ++++-
 fs/debugfs/internal.h                              |  26 ++
 include/linux/debugfs.h                            |  49 ++-
 lib/Kconfig.debug                                  |   1 +
 .../api/debugfs/debugfs_simple_attr.cocci          |  67 ++++
 6 files changed, 592 insertions(+), 88 deletions(-)
 create mode 100644 fs/debugfs/internal.h
 create mode 100644 scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

-- 
2.7.4
