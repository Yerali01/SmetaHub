part of 'user_drafts_bloc.dart';

abstract class UserDraftsEvent {}

class GetDraftProjectsEvent extends UserDraftsEvent {}

class GetDraftEstimatesEvent extends UserDraftsEvent {}
