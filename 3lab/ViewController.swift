import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - IBOutlets
    // (Переконайтесь, що ці елементи підключені до відповідних у Storyboard)
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var sportsSwitch: UISwitch!
    @IBOutlet weak var sportsTitleLabel: UILabel!
    @IBOutlet weak var sportsPickerView: UIPickerView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Дані для переліку (Picker View)
    let sportsList = [
        "Футбол",
        "Баскетбол",
        "Теніс",
        "Плавання",
        "Волейбол",
        "Легка атлетика",
        "Бокс"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportsPickerView.delegate = self
        sportsPickerView.dataSource = self
        
        setupUI()
    }

    private func setupUI() {
        avatarImageView?.image = UIImage(systemName: "person.crop.circle")
        
        ageTextField?.keyboardType = .numberPad
    }

    @IBAction func sportsSwitchChanged(_ sender: UISwitch) {
        let isEnabled = sender.isOn
        
        sportsTitleLabel.isHidden = !isEnabled
        sportsPickerView.isHidden = !isEnabled
    }
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
        let age = ageTextField.text ?? ""
        let city = cityTextField.text ?? ""
        let playsSports = sportsSwitch.isOn
        
        var selectedSport = ""
        if playsSports {
            let selectedRow = sportsPickerView.selectedRow(inComponent: 0)
            selectedSport = sportsList[selectedRow]
        }
        
        var message = "ПІБ: \(name)\nВік: \(age)\nМісто: \(city)\nЗаймається спортом: \(playsSports ? "Так" : "Ні")"
        if playsSports {
            message += "\nУлюблений спорт: \(selectedSport)"
        }
        
        print(message)
        
        // Показ вспливаючого вікна (Alert)
        let alert = UIAlertController(title: "Анкету збережено", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    // MARK: - UIPickerView DataSource & Delegate
    
    // 1. Кількість барабанів (колонок)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 2. Кількість елементів у списку
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sportsList.count
    }
    
    // 3. Текст для кожного елемента (рядка)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sportsList[row]
    }
}
