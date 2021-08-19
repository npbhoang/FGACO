(set-logic UFSLIA)(declare-sort Classifier 0)
(declare-const nullClassifier Classifier)
(declare-const invalidClassifier Classifier)
(declare-const nullInt Int)
(declare-const invalidInt Int)
(declare-const nullString String)
(declare-const invalidString String)
(assert (distinct nullClassifier invalidClassifier))
(assert (distinct nullInt invalidInt))
(assert (distinct nullString invalidString))
(declare-fun Lecturer (Classifier) Bool)
(assert (not (Lecturer nullClassifier)))
(declare-fun Student (Classifier) Bool)
(assert (not (Student nullClassifier)))
(assert (not (Lecturer invalidClassifier)))
(declare-fun age_Lecturer (Classifier) Int)
(assert (= (age_Lecturer nullClassifier) invalidInt))
(assert (= (age_Lecturer invalidClassifier) invalidInt))
(assert (forall ((x Classifier))
    (=> (Lecturer x)
        (distinct (age_Lecturer x) invalidInt))))
(declare-fun email_Lecturer (Classifier) String)
(assert (= (email_Lecturer nullClassifier) invalidString))
(assert (= (email_Lecturer invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Lecturer x)
        (distinct (email_Lecturer x) invalidString))))
(declare-fun name_Lecturer (Classifier) String)
(assert (= (name_Lecturer nullClassifier) invalidString))
(assert (= (name_Lecturer invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Lecturer x)
        (distinct (name_Lecturer x) invalidString))))
(assert (not (Student invalidClassifier)))
(declare-fun age_Student (Classifier) Int)
(assert (= (age_Student nullClassifier) invalidInt))
(assert (= (age_Student invalidClassifier) invalidInt))
(assert (forall ((x Classifier))
    (=> (Student x)
        (distinct (age_Student x) invalidInt))))
(declare-fun name_Student (Classifier) String)
(assert (= (name_Student nullClassifier) invalidString))
(assert (= (name_Student invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Student x)
        (distinct (name_Student x) invalidString))))
(declare-fun email_Student (Classifier) String)
(assert (= (email_Student nullClassifier) invalidString))
(assert (= (email_Student invalidClassifier) invalidString))
(assert (forall ((x Classifier))
    (=> (Student x)
        (distinct (email_Student x) invalidString))))
(declare-fun Enrollment (Classifier Classifier) Bool)
(assert (forall ((x Classifier))
    (forall ((y Classifier)) 
        (=> (Enrollment x y) 
            (and (Lecturer x) (Student y))))))
(assert (forall ((x Classifier)) 
    (=> (Lecturer x) (not (Student x)))))
(assert (forall ((x Classifier)) 
    (=> (Student x) (not (Lecturer x)))))
(assert (forall ((l Classifier)) (and (=> (Lecturer l) (forall ((s Classifier)) (and (=> (Student s) (exists ((temp Classifier)) (and (Enrollment l temp) (= temp s) (not (or (= l nullClassifier) (= l invalidClassifier))) (not (= s invalidClassifier))))) (not false)))) (not false))))
(declare-const kcaller Classifier)
(assert (Lecturer kcaller))
(declare-const klecturers Classifier)
(assert (Lecturer klecturers))
(declare-const kstudents Classifier)
(assert (Student kstudents))
(assert (Enrollment klecturers kstudents))
(assert (not (exists ((temp Classifier)) (and (Enrollment temp kstudents) (= temp kcaller) (not (or (= kstudents nullClassifier) (= kstudents invalidClassifier))) (not (= kcaller invalidClassifier))))))
(check-sat)
