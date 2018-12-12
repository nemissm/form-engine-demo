//
//  ExampleCells.swift
//  FormEngineDemo
//
//  Created by Mikhail Naryshkin on 13/12/2018.
//

import UIKit

// MARK: ExampleFormSection

class ExampleFormSection: FormSection {
    var headerTitle: String?
    var cellModels: [FormCellModel] = []
}

// MARK: ExamplePlainCell

class ExamplePlainCellModel: FormCellModel {
    var title: String = ""

    var reuseIdentifier: String {
        return String(describing: ExamplePlainCell.self)
    }

    var selectionHandler: FormCellSelectionHandler?
}

class ExamplePlainCell: UITableViewCell, FormCell {
    func configureWith(cellModel: ExamplePlainCellModel) {
        textLabel?.text = cellModel.title
    }
}

// MARK: ExamplePlainCell

class ExampleSubtitleSwitchCellModel: FormCellModel {
    var title: String = ""
    var subtitle: String = ""

    var isOn: Bool = false

    var reuseIdentifier: String {
        return String(describing: ExampleSubtitleSwitchCell.self)
    }

    var selectionHandler: FormCellSelectionHandler?
    var switchHandler: FormCellSelectionHandler?
}

class ExampleSubtitleSwitchCell: UITableViewCell, FormCell {
    weak var cellModel: ExampleSubtitleSwitchCellModel?

    lazy var switchView: UISwitch = {
        let switchView = UISwitch(frame: .zero)
        switchView.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)

        return switchView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        accessoryView = switchView
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func switchValueChanged() {
        guard let cellModel = cellModel else {
            return
        }

        cellModel.isOn = switchView.isOn
        cellModel.switchHandler?(cellModel)
    }

    func configureWith(cellModel: ExampleSubtitleSwitchCellModel) {
        self.cellModel = cellModel

        textLabel?.text = cellModel.title
        detailTextLabel?.text = cellModel.subtitle

        switchView.isOn = cellModel.isOn
    }
}
