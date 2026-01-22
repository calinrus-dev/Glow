/// Domain layer entities and business rules
library;

// Entities - Auth
export 'src/entities/auth/user_entity.dart';
export 'src/entities/auth/session_entity.dart';
export 'src/entities/auth/identity_entity.dart';

// Entities - Social
export 'src/entities/social/world_entity.dart';
export 'src/entities/social/environment_entity.dart';
export 'src/entities/social/channel_entity.dart';
export 'src/entities/social/post_entity.dart';
export 'src/entities/social/comment_entity.dart';
export 'src/entities/social/reaction_entity.dart';

// Entities - Chat
export 'src/entities/chat/conversation_entity.dart';
export 'src/entities/chat/message_entity.dart';

// Entities - Governance
export 'src/entities/governance/permission_entity.dart';
export 'src/entities/governance/role_entity.dart';
export 'src/entities/governance/policy_entity.dart';

// Policies
export 'src/policies/permission_policy.dart';
export 'src/policies/content_policy.dart';
