//
//  CellModel.swift
//  FormEngineDemo
//
//  Created by Mikhail Naryshkin on 28/11/2018.
//

import UIKit

// MARK: FormSection

protocol FormSection {
    var headerTitle: String? { get set }
    var cellModels: [FormCellModel] { get set }
}

// MARK: FormCellModel

typealias FormCellSelectionHandler = (_: FormCellModel) -> ()

protocol FormCellModel {
    // Чтобы иметь возможность использовать одну cellModel для разных ячеек
    var reuseIdentifier: String { get }
    
    var selectionHandler: FormCellSelectionHandler? { get set }
}

// MARK: FormCell

protocol FormCell: FormConfigurableCell {
    associatedtype FormCellModelType: FormCellModel

    // Хранить cellModel внутри ячейки или нет решает каждый сам в зависимости от задачи.
    // Наверно если нужно хранить, то делать это weak ссылкой для cellModel, которые идут reference type.
    // Вообще, есть ли смысл cellModel'ы делать valueType?
    func configureWith(cellModel: FormCellModelType)
}

// Чтобы уйти от generic протокола в cellForRow.
// Идея описана тут: https://youtu.be/Ge73dsgXf_M?t=1637
protocol FormConfigurableCell {
    func configureWith(cellModel: FormCellModel)
}

extension FormCell {
    func configureWith(cellModel: FormCellModel) {
        configureWith(cellModel: cellModel as! FormCellModelType)
    }
}
