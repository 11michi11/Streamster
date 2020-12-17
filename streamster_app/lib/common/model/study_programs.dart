enum StudyPrograms { GBE, ICT, ME, CE, MM, VCE }

extension StudyProgramAsString on StudyPrograms {

  String get name {
    switch(this) {
      case StudyPrograms.GBE:
        return 'Global Business Engineering';
      case StudyPrograms.ICT:
        return 'Software Engineering';
      case StudyPrograms.ME:
        return 'Mechanical Engineering';
      case StudyPrograms.CE:
        return 'Civil Engineering';
      case StudyPrograms.MM:
        return 'Marketing Management';
      case StudyPrograms.VCE:
        return 'Value Chain';
      default:
        return null;
    }
  }

  String get program {
    switch(this) {
      case StudyPrograms.GBE:
        return 'GBE';
      case StudyPrograms.ICT:
        return 'ICT';
      case StudyPrograms.ME:
        return 'ME';
      case StudyPrograms.CE:
        return 'CE';
      case StudyPrograms.MM:
        return 'MM';
      case StudyPrograms.VCE:
        return 'VCE';
      default:
        return null;
    }
  }
}